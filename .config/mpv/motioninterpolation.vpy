# vim: set ft=python:

# see the README at https://gist.github.com/phiresky/4bfcfbbd05b3c2ed8645
# source: https://github.com/mpv-player/mpv/issues/2149
# source: https://github.com/mpv-player/mpv/issues/566
# source: https://github.com/haasn/gentoo-conf/blob/nanodesu/home/nand/.mpv/filters/mvtools.vpy

import vapoursynth

core = vapoursynth.get_core()
# ref: http://avisynth.org.ru/mvtools/mvtools2.html#functions
# default is 400, less means interpolation will only happen when it will work well
ignore_threshold=140
# if n% of blocks change more than threshold then don't interpolate at all (default is 51%)
scene_change_percentage=15

dst_fps = display_fps
# Interpolating to fps higher than 60 is too CPU-expensive, smoothmotion can handle the rest.
# while (dst_fps > 60):
#    dst_fps /= 2

if "video_in" in globals():
    # realtime
    clip = video_in
    # Needed because clip FPS is missing
    src_fps_num = int(container_fps * 1e8)
    src_fps_den = int(1e8)
    clip = core.std.AssumeFPS(clip, fpsnum = src_fps_num, fpsden = src_fps_den)
else:
    # run with vspipe
    clip = core.ffms2.Source(source=in_filename)
    dst_fps=float(dst_fps)

# resolution in megapixels. 1080p ≈ 2MP, 720p ≈ 1MP
mpix = clip.width * clip.height / 1000000

# Skip interpolation for >1080p or 60 Hz content due to performance
if not (mpix > 2.5 or clip.fps_num/clip.fps_den > 59):
    analParams = {
        'overlap': 0,
        'search': 3,
        'truemotion': True,
        #'chrome': True,
        #'blksize':16,
        #'searchparam':1
    }
    blockParams = {
        'thscd1': ignore_threshold,
        'thscd2': int(scene_change_percentage*255/100),
        'mode': 3,
    }

    if mpix > 1.5:
        # can't handle these on Full HD with Intel i5-2500k
        # see the description of these parameters in http://avisynth.org.ru/mvtools/mvtools2.html#functions
        analParams['search'] = 0
        blockParams['mode'] = 0
        quality = 'low'
    else:
        quality = 'high'


    dst_fps_num = int(dst_fps * 1e4)
    dst_fps_den = int(1e4)
    print("Reflowing from {} fps to {} fps (quality={})".format(clip.fps_num/clip.fps_den,dst_fps_num/dst_fps_den,quality))

    sup  = core.mv.Super(clip, pel=2)
    bvec = core.mv.Analyse(sup, isb=True, **analParams)
    fvec = core.mv.Analyse(sup, isb=False, **analParams)
    clip = core.mv.BlockFPS(clip, sup, bvec, fvec,
            num=dst_fps_num, den=dst_fps_den,
            **blockParams)

clip.set_output()
