local msg = require('mp.msg')
local bar_height = 2
local hover_zone = 20
local log = {
  debug = function(format, ...)
    return msg.debug(format:format(...))
  end,
  info = function(format, ...)
    return msg.info(format:format(...))
  end,
  warn = function(format, ...)
    return msg.warn(format:format(...))
  end,
  dump = function(item, ignore)
    local level = 2
    if "table" ~= type(item) then
      msg.info(tostring(item))
      return 
    end
    local count = 1
    local tablecount = 1
    local result = {
      "{ @" .. tostring(tablecount)
    }
    local seen = {
      [item] = tablecount
    }
    local recurse
    recurse = function(item, space)
      for key, value in pairs(item) do
        if not (key == ignore) then
          if "table" == type(value) then
            if not (seen[value]) then
              tablecount = tablecount + 1
              seen[value] = tablecount
              count = count + 1
              result[count] = space .. tostring(key) .. ": { @" .. tostring(tablecount)
              recurse(value, space .. "  ")
              count = count + 1
              result[count] = space .. "}"
            else
              count = count + 1
              result[count] = space .. tostring(key) .. ": @" .. tostring(seen[value])
            end
          else
            if "string" == type(value) then
              value = ("%q"):format(value)
            end
            count = count + 1
            result[count] = space .. tostring(key) .. ": " .. tostring(value)
          end
        end
      end
    end
    recurse(item, "  ")
    count = count + 1
    result[count] = "}"
    return msg.info(table.concat(result, "\n"))
  end
}
local OSDAggregator
do
  local _base_0 = {
    addSubscriber = function(self, subscriber)
      if not subscriber then
        return 
      end
      self.subscriberCount = self.subscriberCount + 1
      subscriber.aggregatorIndex = self.subscriberCount
      self.subscribers[self.subscriberCount] = subscriber
      self.script[self.subscriberCount] = subscriber:stringify()
    end,
    removeSubscriber = function(self, index)
      table.remove(self.subscribers, index)
      table.remove(self.script, index)
      self.subscriberCount = self.subscriberCount - 1
      for i = index, self.subscriberCount do
        self.subscribers[i].aggregatorIndex = i
      end
    end,
    update = function(self, force)
      if force == nil then
        force = false
      end
      local needsRedraw = force
      local x, y = mp.get_mouse_pos()
      local w, h = mp.get_screen_size()
      local needsResize = false
      if w ~= self.w or h ~= self.h then
        self.w, self.h = w, h
        needsResize = true
      end
      for sub = 1, self.subscriberCount do
        local theSub = self.subscribers[sub]
        local update = false
        if theSub:update(x, y, self.mouseOver) then
          update = true
        end
        if (needsResize and theSub:updateSize(w, h)) or update then
          needsRedraw = true
          self.script[sub] = theSub:stringify()
        end
      end
      if true == needsRedraw then
        return mp.set_osd_ass(self.w, self.h, table.concat(self.script, '\n'))
      end
    end,
    pause = function(self, event, paused)
      self.paused = paused
      if self.paused then
        return self.updateTimer:stop()
      else
        return self.updateTimer:resume()
      end
    end,
    forceUpdate = function(self)
      self.updateTimer:kill()
      self:update(true)
      if not (self.paused) then
        return self.updateTimer:resume()
      end
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self)
      self.script = { }
      self.subscribers = { }
      self.subscriberCount = 0
      self.mouseOver = false
      self.w = 0
      self.h = 0
      local redrawFrequency = 0.05
      self.updateTimer = mp.add_periodic_timer(redrawFrequency, (function()
        local _base_1 = self
        local _fn_0 = _base_1.update
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
      mp.register_event('shutdown', function()
        return self.updateTimer:kill()
      end)
      mp.add_key_binding("MOUSE_LEAVE", function()
        self.mouseOver = false
      end)
      return mp.add_key_binding("MOUSE_ENTER", function()
        self.mouseOver = true
      end)
    end,
    __base = _base_0,
    __name = "OSDAggregator"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  OSDAggregator = _class_0
end
local AnimationQueue
do
  local _base_0 = {
    registerAnimation = function(self, animation)
      if self.list then
        self.list.next = animation
      end
      animation.prev = self.list
      animation.isRegistered = true
      self.list = animation
      self.animationCount = self.animationCount + 1
      return self:startAnimation()
    end,
    unregisterAnimation = function(self, animation)
      local prev = animation.prev
      local next = animation.next
      if prev then
        prev.next = next
      end
      if next then
        next.prev = prev
      end
      if self.list == animation then
        self.list = prev
      end
      animation.next = nil
      animation.prev = nil
      animation.isRegistered = false
      self.animationCount = self.animationCount - 1
      if 0 == self.animationCount then
        self:stopAnimation()
      end
      return prev
    end,
    startAnimation = function(self)
      if self.animating then
        return 
      end
      self.timer:resume()
      self.animating = true
    end,
    stopAnimation = function(self)
      if not (self.animating) then
        return 
      end
      self.timer:kill()
      self.animating = false
    end,
    destroyAnimationStack = function(self)
      self:stopAnimation()
      local currentAnimation = self.list
      while currentAnimation do
        currentAnimation = self.list.prev
        self.list.prev = nil
        self.list.next = nil
        self.list = currentAnimation
      end
    end,
    animate = function(self)
      local currentAnimation = self.list
      local currentTime = mp.get_time()
      while currentAnimation do
        if currentAnimation:update(currentTime) then
          currentAnimation = self:unregisterAnimation(currentAnimation)
        else
          currentAnimation = currentAnimation.prev
        end
      end
      return self.aggregator:forceUpdate()
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, aggregator)
      self.aggregator = aggregator
      self.list = nil
      self.animationCount = 0
      self.animating = false
      self.timer = mp.add_periodic_timer(0.05, (function()
        local _base_1 = self
        local _fn_0 = _base_1.animate
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
      return self.timer:kill()
    end,
    __base = _base_0,
    __name = "AnimationQueue"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  AnimationQueue = _class_0
end
local Animation
do
  local _base_0 = {
    update = function(self, currentTime)
      self.currentTime = currentTime
      local progress = math.max(0, math.min(1, (self.currentTime - self.startTime) * self.durationR))
      if progress == 1 then
        self.isFinished = true
      end
      if self.accel then
        progress = math.pow(progress, self.accel)
      end
      local value = (1 - progress) * self.initialValue + progress * self.endValue
      self:updateCb(value)
      if self.isFinished and self.finishedCb then
        self:finishedCb()
      end
      return self.isFinished
    end,
    interrupt = function(self, reverse, queue)
      if reverse ~= self.isReversed then
        self:reverse()
      end
      if not (self.isRegistered) then
        self:restart()
        return queue:registerAnimation(self)
      end
    end,
    reverse = function(self)
      self.isReversed = not self.isReversed
      self.initialValue, self.endValue = self.endValue, self.initialValue
      self.startTime = 2 * self.currentTime - self.duration - self.startTime
      self.accel = 1 / self.accel
    end,
    restart = function(self)
      self.startTime = mp.get_time()
      self.currentTime = self.startTime
      self.isFinished = false
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, initialValue, endValue, duration, updateCb, finishedCb, accel)
      if accel == nil then
        accel = 1
      end
      self.initialValue, self.endValue, self.duration, self.updateCb, self.finishedCb, self.accel = initialValue, endValue, duration, updateCb, finishedCb, accel
      self.startTime = mp.get_time()
      self.currentTime = self.startTime
      self.durationR = 1 / self.duration
      self.isFinished = (self.duration <= 0)
      self.isRegistered = false
      self.isReversed = false
    end,
    __base = _base_0,
    __name = "Animation"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Animation = _class_0
end
local Rect
do
  local _base_0 = {
    setPosition = function(self, x, y)
      self.x = x or self.x
      self.y = y or self.y
    end,
    setDimensions = function(self, w, h)
      self.w = w or self.w
      self.h = h or self.h
    end,
    move = function(self, x, y)
      self.x = self.x + (x or 0)
      self.y = self.y + (y or 0)
    end,
    stretch = function(self, w, h)
      self.w = self.w + (w or 0)
      self.h = self.h + (h or 0)
    end,
    containsPoint = function(self, x, y)
      return ((x >= self.x) and (y >= self.y) and (x < self.x + self.w) and (y < self.y + self.h))
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, x, y, w, h)
      self.x, self.y, self.w, self.h = x, y, w, h
    end,
    __base = _base_0,
    __name = "Rect"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Rect = _class_0
end
local Subscriber
do
  local _parent_0 = Rect
  local _base_0 = {
    stringify = function(self)
      if not self.hovered and not self.animation.isRegistered then
        return ""
      end
      return table.concat(self.line)
    end,
    updateSize = function(self, w, h)
      self.y = h - hover_zone * bar_height
      self.w, self.h = w, hover_zone * bar_height
    end,
    update = function(self, mouseX, mouseY, mouseOver, hoverCondition)
      if hoverCondition == nil then
        hoverCondition = self:containsPoint(mouseX, mouseY)
      end
      local update = self.needsUpdate
      self.needsUpdate = false
      if mouseOver and hoverCondition then
        if not (self.hovered) then
          update = true
          self.hovered = true
          self.animation:interrupt(false, self.animationQueue)
        end
      else
        if self.hovered then
          update = true
          self.hovered = false
          self.animation:interrupt(true, self.animationQueue)
        end
      end
      return update
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self)
      _parent_0.__init(self, 0, 0, 0, 0)
      self.hovered = false
      self.needsUpdate = false
    end,
    __base = _base_0,
    __name = "Subscriber",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Subscriber = _class_0
end
local ProgressBar
do
  local _parent_0 = Subscriber
  local _base_0 = {
    clickUpSeek = function(self)
      local x, y = mp.get_mouse_pos()
      if self:containsPoint(x, y) then
        return mp.commandv("seek", x * 100 / self.w, "absolute-percent", "keyframes")
      end
    end,
    stringify = function(self)
      return table.concat(self.line)
    end,
    updateSize = function(self, w, h)
      _parent_0.updateSize(self, w, h)
      self.line[2] = ([[%d,%d]]):format(0, h)
      self.line[8] = ([[%d 0 %d %d 0 %d]]):format(w * 4, w * 4, bar_height * 4, bar_height * 4)
      return true
    end,
    animateHeight = function(self, animation, value)
      self.line[6] = ([[%g]]):format(value)
      self.needsUpdate = true
    end,
    update = function(self, mouseX, mouseY, mouseOver)
      local update = _parent_0.update(self, mouseX, mouseY, mouseOver)
      local position = mp.get_property_number('percent-pos', 0)
      if position ~= self.lastPosition then
        update = true
        self.line[4] = ([[%g]]):format(position)
        self.lastPosition = position
      end
      return update
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, animationQueue)
      self.animationQueue = animationQueue
      _parent_0.__init(self)
      self.line = {
        [[{\an1\bord0\c&HFFFFFF&\p3\pos(]],
        0,
        [[)\fscx]],
        0,
        [[\fscy]],
        100,
        [[}m 0 0 l ]],
        0
      }
      self.lastPosition = 0
      self.animation = Animation(100, 400, 0.25, (function()
        local _base_1 = self
        local _fn_0 = _base_1.animateHeight
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
      return mp.add_key_binding("MOUSE_BTN0", (function()
        local _base_1 = self
        local _fn_0 = _base_1.clickUpSeek
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
    end,
    __base = _base_0,
    __name = "ProgressBar",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  ProgressBar = _class_0
end
local ProgressBarBackground
do
  local _parent_0 = Subscriber
  local _base_0 = {
    stringify = function(self)
      return table.concat(self.line)
    end,
    updateSize = function(self, w, h)
      _parent_0.updateSize(self, w, h)
      self.line[2] = ([[%d,%d]]):format(0, h)
      self.line[6] = ([[%d 0 %d %d 0 %d]]):format(w, w, bar_height, bar_height)
      return true
    end,
    animateHeight = function(self, animation, value)
      self.line[4] = ([[%g]]):format(value)
      self.needsUpdate = true
    end,
    update = function(self, mouseX, mouseY, mouseOver)
      return _parent_0.update(self, mouseX, mouseY, mouseOver)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, animationQueue)
      self.animationQueue = animationQueue
      _parent_0.__init(self)
      self.line = {
        [[{\an1\bord0\c&H262626&\p1\pos(]],
        0,
        [[)\fscy]],
        100,
        [[}m 0 0 l ]],
        0
      }
      self.animation = Animation(100, 400, 0.25, (function()
        local _base_1 = self
        local _fn_0 = _base_1.animateHeight
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
    end,
    __base = _base_0,
    __name = "ProgressBarBackground",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  ProgressBarBackground = _class_0
end
local ChapterMarker
do
  local _parent_0 = Subscriber
  local _base_0 = {
    stringify = function(self)
      if self.passed then
        self.line[2][7] = [[\c&H262626&]]
      else
        self.line[2][7] = [[\c&HFFFFFF&]]
      end
      if self.hovered or self.animation.isRegistered then
        return table.concat({
          table.concat(self.line[1]),
          table.concat(self.line[2])
        }, '\n')
      else
        return table.concat(self.line[2])
      end
    end,
    updateSize = function(self, w, h)
      self.x = math.floor(w * self.position)
      self.y = h - hover_zone * bar_height
      self.line[1][2] = ([[%d,%d]]):format(self.x + 10, h - hover_zone - 10)
      self.line[2][2] = ([[%d,%d]]):format(self.x + 10, h)
      return true
    end,
    animateAlpha = function(self, animation, value)
      self.line[1][4] = ([[%02X]]):format(value)
      self.needsUpdate = true
    end,
    animateSize = function(self, value)
      self.line[2][4] = ([[%g]]):format(value * 100 + 100)
      self.line[2][6] = ([[%g]]):format(value * 300 + 100)
    end,
    update = function(self, mouseX, mouseY, mouseOver, position)
      local update = _parent_0.update(self, mouseX, mouseY, mouseOver)
      local changed = self.passed
      self.passed = position > self.position
      update = update or changed ~= self.passed
      return update
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, animationQueue, title, position, w, h)
      self.animationQueue, self.position = animationQueue, position
      _parent_0.__init(self)
      self.x = math.floor(w * self.position) - 10
      self.y = h - hover_zone * bar_height
      self.w = 20
      self.h = hover_zone * bar_height
      self.line = {
        {
          [[{\an2\bord2\c&H262626&\3c&HFFFFFF\fs30\pos(]],
          ([[%d,%d]]):format(self.x + 10, h - hover_zone - 10),
          [[)\alpha&H]],
          [[FF]],
          ([[&}%s]]):format(title)
        },
        {
          [[{\an2\bord0\p1\pos(]],
          ([[%d,%d]]):format(self.x + 10, h),
          [[)\fscx]],
          100,
          [[\fscy]],
          100,
          [[\c&HFFFFFF&]],
          [[}m 0 0 l 2 0 2 2 0 2]]
        }
      }
      self.passed = false
      self.animation = Animation(255, 0, 0.25, (function()
        local _base_1 = self
        local _fn_0 = _base_1.animateAlpha
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
    end,
    __base = _base_0,
    __name = "ChapterMarker",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  ChapterMarker = _class_0
end
local Chapters
do
  local _parent_0 = Subscriber
  local _base_0 = {
    createMarkers = function(self, w, h)
      self.markers = { }
      local totalTime = mp.get_property_number('length', 0)
      local chapters = mp.get_property_native('chapter-list', { })
      for _index_0 = 1, #chapters do
        local chapter = chapters[_index_0]
        table.insert(self.markers, ChapterMarker(self.animationQueue, chapter.title, chapter.time / totalTime, w, h))
      end
    end,
    stringify = function(self)
      return table.concat(self.line, '\n')
    end,
    redrawMarkers = function(self)
      self.line = { }
      local _list_0 = self.markers
      for _index_0 = 1, #_list_0 do
        local marker = _list_0[_index_0]
        table.insert(self.line, marker:stringify())
      end
    end,
    updateSize = function(self, w, h)
      _parent_0.updateSize(self, w, h)
      local _list_0 = self.markers
      for _index_0 = 1, #_list_0 do
        local marker = _list_0[_index_0]
        marker:updateSize(w, h)
      end
      self:redrawMarkers()
      return true
    end,
    animateSize = function(self, animation, value)
      local _list_0 = self.markers
      for _index_0 = 1, #_list_0 do
        local marker = _list_0[_index_0]
        marker:animateSize(value)
      end
      self.needsUpdate = true
    end,
    update = function(self, mouseX, mouseY, mouseOver)
      local update = _parent_0.update(self, mouseX, mouseY, mouseOver)
      local currentPosition = mp.get_property_number('percent-pos', 0) * 0.01
      local _list_0 = self.markers
      for _index_0 = 1, #_list_0 do
        local marker = _list_0[_index_0]
        if marker:update(mouseX, mouseY, mouseOver, currentPosition) then
          update = true
        end
      end
      if update then
        self:redrawMarkers()
      end
      return update
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, animationQueue)
      self.animationQueue = animationQueue
      _parent_0.__init(self)
      self.line = { }
      self.markers = { }
      self.animation = Animation(0, 1, 0.25, (function()
        local _base_1 = self
        local _fn_0 = _base_1.animateSize
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
    end,
    __base = _base_0,
    __name = "Chapters",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Chapters = _class_0
end
local TimeElapsed
do
  local _parent_0 = Subscriber
  local _base_0 = {
    updateSize = function(self, w, h)
      _parent_0.updateSize(self, w, h)
      self.line[2] = ([[%g,%g]]):format(self.position, self.y + (hover_zone - 4) * bar_height)
      return true
    end,
    animatePos = function(self, animation, value)
      self.position = value
      self.line[2] = ([[%g,%g]]):format(self.position, self.y + (hover_zone - 4) * bar_height)
      self.needsUpdate = true
    end,
    update = function(self, mouseX, mouseY, mouseOver)
      local update = _parent_0.update(self, mouseX, mouseY, mouseOver)
      local timeElapsed = math.floor(mp.get_property_number('time-pos', 0))
      if timeElapsed ~= self.lastTime then
        update = true
        self.line[4] = ([[%d:%02d:%02d]]):format(timeElapsed / 3600, (timeElapsed / 60) % 60, timeElapsed % 60)
        self.lastTime = timeElapsed
      end
      return update
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, animationQueue)
      self.animationQueue = animationQueue
      _parent_0.__init(self)
      self.line = {
        [[{\fnSource Sans Pro Semibold\bord2\fs30\pos(]],
        [[-100,0]],
        [[)\3c&H262626&\c&HFFFFFF&\an1}]],
        0
      }
      self.lastTime = -1
      self.position = -100
      self.animation = Animation(-100, 2, 0.25, (function()
        local _base_1 = self
        local _fn_0 = _base_1.animatePos
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)(), nil, 0.25)
    end,
    __base = _base_0,
    __name = "TimeElapsed",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  TimeElapsed = _class_0
end
local TimeRemaining
do
  local _parent_0 = Subscriber
  local _base_0 = {
    updateSize = function(self, w, h)
      _parent_0.updateSize(self, w, h)
      self.line[2] = ([[%g,%g]]):format(self.position, self.y + (hover_zone - 4) * bar_height)
      return true
    end,
    animatePos = function(self, animation, value)
      self.position = self.w - value
      self.line[2] = ([[%g,%g]]):format(self.position, self.y + (hover_zone - 4) * bar_height)
      self.needsUpdate = true
    end,
    update = function(self, mouseX, mouseY, mouseOver)
      local update = _parent_0.update(self, mouseX, mouseY, mouseOver)
      local timeRemaining = math.floor(mp.get_property_number('playtime-remaining', 0))
      if timeRemaining ~= self.lastTime then
        update = true
        self.line[4] = ([[%d:%02d:%02d]]):format(timeRemaining / 3600, (timeRemaining / 60) % 60, timeRemaining % 60)
        self.lastTime = timeRemaining
      end
      return update
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, animationQueue)
      self.animationQueue = animationQueue
      _parent_0.__init(self, 0, 0, 0, 0)
      self.line = {
        [[{\fnSource Sans Pro Semibold\bord2\fs30\pos(]],
        [[-100,0]],
        [[)\3c&H262626&\c&HFFFFFF&\an3}]],
        0
      }
      self.lastTime = -1
      self.position = -100
      self.animation = Animation(-100, 4, 0.25, (function()
        local _base_1 = self
        local _fn_0 = _base_1.animatePos
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)(), nil, 0.25)
    end,
    __base = _base_0,
    __name = "TimeRemaining",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  TimeRemaining = _class_0
end
local HoverTime
do
  local _parent_0 = Subscriber
  local _base_0 = {
    animateAlpha = function(self, animation, value)
      self.line[4] = ([[%02X]]):format(value)
      self.needsUpdate = true
    end,
    update = function(self, mouseX, mouseY, mouseOver)
      local update = _parent_0.update(self, mouseX, mouseY, mouseOver)
      if mouseX ~= self.lastX or mouseY ~= self.lastY then
        self.line[2] = ("%g,%g"):format(math.min(self.w - 130, math.max(120, mouseX)), self.y + (hover_zone - 4) * bar_height)
        self.lastX, self.lastY = mouseX, mouseY
        local hoverTime = mp.get_property_number('length', 0) * mouseX / self.w
        if hoverTime ~= self.lastTime and (self.hovered or self.animation.isRegistered) then
          update = true
          self.line[6] = ([[%d:%02d:%02d]]):format(hoverTime / 3600, (hoverTime / 60) % 60, hoverTime % 60)
          self.lastTime = hoverTime
        end
      end
      return update
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, animationQueue)
      self.animationQueue = animationQueue
      _parent_0.__init(self)
      self.line = {
        [[{\fnSource Sans Pro Semibold\bord2\fs26\pos(]],
        [[-100,0]],
        [[)\3c&H262626&\c&HFFFFFF&\an2\&H]],
        [[FF]],
        [[&}]],
        0
      }
      self.lastTime = 0
      self.lastX = -1
      self.lastY = -1
      self.position = -100
      self.animation = Animation(255, 0, 0.25, (function()
        local _base_1 = self
        local _fn_0 = _base_1.animateAlpha
        return function(...)
          return _fn_0(_base_1, ...)
        end
      end)())
    end,
    __base = _base_0,
    __name = "HoverTime",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  HoverTime = _class_0
end
local aggregator = OSDAggregator()
local animationQueue = AnimationQueue(aggregator)
local progressBar = ProgressBar(animationQueue)
local progressBarBackground = ProgressBarBackground(animationQueue)
local chapters = Chapters(animationQueue)
local timeElapsed = TimeElapsed(animationQueue)
local timeRemaining = TimeRemaining(animationQueue)
local hoverTime = HoverTime(animationQueue)
aggregator:addSubscriber(progressBarBackground)
aggregator:addSubscriber(progressBar)
aggregator:addSubscriber(chapters)
aggregator:addSubscriber(timeElapsed)
aggregator:addSubscriber(timeRemaining)
aggregator:addSubscriber(hoverTime)
local notFrameStepping = true
mp.add_key_binding('.', 'mp_progbar_stepforward', function()
  notFrameStepping = false
  return mp.commandv('frame_step')
end, {
  repeatable = true
})
mp.add_key_binding(',', 'mp_progbar_stepbackward', function()
  notFrameStepping = false
  return mp.commandv('frame_back_step')
end, {
  repeatable = true
})
mp.observe_property('pause', 'bool', PauseIndicatorWrapper)
local initDraw
initDraw = function()
  mp.unregister_event(initDraw)
  local width, height = mp.get_screen_size()
  chapters:createMarkers(width, height)
end
local fileLoaded
fileLoaded = function()
  return mp.register_event('playback-restart', initDraw)
end
return mp.register_event('file-loaded', fileLoaded)
