// https://www.shadertoy.com/view/3tfyD4
// created by TRASHTRASH aka Joshua deLorimier

#define iter 40.0
#define scaleSpeed 3.0
#define satSpeed 4.2

// Dave Hoskins - noise - https://www.shadertoy.com/view/4djSRW
float N2(vec2 p) {
  vec3 p3 = fract(vec3(p.xyx) * vec3(443.897, 441.423, 437.195));
  p3 += dot(p3, p3.yzx + 19.19);
  return fract((p3.x + p3.y) * p3.z);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
  uv *= 3.0;

  uv *= iter;
  vec2 gv = fract(uv) - 0.5;
  vec2 id = floor(uv);
  float ran = N2(id);
  float ran2 = N2(id + 64.0);
  vec2 d = abs(gv) - (abs(sin((iTime * scaleSpeed) * ran) * 0.5) - 0.05);
  float rect = min(max(d.x, d.y), 0.0) + length(max(d, 0.));
  float r = step(0., rect);
  vec3 col = vec3(1. - r) * vec3(abs(sin((iTime * satSpeed) * ran2)) * .8);
  col *= vec3(.3, .8, 0.4);
  fragColor = vec4(col, 0.0);
}
