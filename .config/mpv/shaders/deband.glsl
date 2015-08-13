// vim: set ft=glsl:

// roughly corresponds to f3kdb parameters, which this algorithm is
// loosely inspired by
#define threshold 64
#define range     16
#define grain     24

float rand(vec2 co) {
    return fract(sin(dot(co.yx, vec2(12.9898,78.233))) * 43758.5453);
}

vec4 sample(sampler2D tex, vec2 pos, vec2 tex_size)
{
    // Compute a random angle and distance
    float dist = rand(pos + vec2(random)) * range;
    vec2 pt = dist / image_size;
    float dir = rand(pos.yx - vec2(random)) * 6.2831853;
    vec2 o = vec2(cos(dir), sin(dir));

    // Sample at quarter-turn intervals around the source pixel
    vec4 ref[4];
    ref[0] = texture(tex, pos + pt * vec2( o.x,  o.y));
    ref[1] = texture(tex, pos + pt * vec2(-o.y,  o.x));
    ref[2] = texture(tex, pos + pt * vec2(-o.x, -o.y));
    ref[3] = texture(tex, pos + pt * vec2( o.y, -o.x));

    // Average and compare with the actual sample
    vec4 avg = cmul*(ref[0] + ref[1] + ref[2] + ref[3])/4.0;
    vec4 col = cmul*texture(tex, pos);
    vec4 diff = abs(col - avg);

    // Use the average if below the threshold
    col = mix(avg, col, greaterThan(diff, vec4(threshold/16384.0)));

    // Add some random noise to the output
    vec3 noise = vec3(rand(2*pos + vec2(random)),
                      rand(3*pos + vec2(random)),
                      rand(4*pos + vec2(random)));
    col.rgb += (grain/8192.0) * (noise - vec3(0.5));
    return col;
}
