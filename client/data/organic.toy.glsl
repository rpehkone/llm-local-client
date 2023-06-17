// https://www.shadertoy.com/view/DsVSDR
// original here https://twitter.com/zozuar/status/1621229990267310081
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 n, q, p = (fragCoord - iResolution.xy * 0.1) / iResolution.y;
  	p*=1.3;//zoom
    float d = dot(p, p), S = 15.0, a = 0.0, j = 0.0;

    for (float i = 0.0; i < 30.0; i++) {
        mat2 m = mat2(cos(5.0), -sin(5.0), sin(5.0), cos(5.0));
        p *= m; n *= m;
        q = p*S + iTime*4.0 + sin(iTime*4.0 - d*6.0)*0.8 + j + n;
        a += dot(cos(q)/S, vec2(0.2));
        n -= sin(q);
        S *= 1.2;
        j += 1.0;
    }
    vec4 res = (a + 0.2)*vec4(4.0, 2.0, 1.0, 0.0) + a + a - d;

    vec2 mousen = iMouse.xy / iResolution.xy;
    vec2 uv = fragCoord / iResolution.xy;
    // Correct for the aspect ratio
    float aspectRatio = iResolution.x / iResolution.y;
    mousen.x *= aspectRatio;
    uv.x *= aspectRatio;
    float dist = distance(mousen, uv) * 3.0;

    if (dist < 0.2) {
         float tmp = 1.0 - (dist / 0.2);
         res += tmp / 2.;
    }
    if (dist < 0.1) {
         dist /= 0.1;
         res.b /= dist;
    }
    fragColor = res;
}
