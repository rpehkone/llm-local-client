// https://www.shadertoy.com/view/ft3yzf

#define ss smoothstep

int B[] =
int[9](0, 4096, 65600, 332772, 15255086, 14726438, 23385164, 15252014, 11512810);
/*            .    :      *       o        @        &        8        #    */

// Time speed control
// #define FPS 10.
// #define iTime floor(iTime*FPS)*.01

void mainImage(out vec4 O, vec2 U) {
  vec2 U = fragCoord.xy * 5.;
  vec2 R = iResolution.xy, s = vec2(1, -R.y / R.x) * R.x / 7.,
       p = (U - R * .5) * s / R, o = floor(p) / s;
  p = floor(fract(p) * 7.);
  float q = length(o),

        /*                   E*5                     TAU                   */
      I = mod(log(q) / log(13.5914) + atan(o.x, o.y) / 6.28318 - iTime * .3,
              .5) *
          2.;
  I = min(ss(.0, .4, I) - ss(.6, 1., I),
          ss(0., .5, pow(sin(iTime - q * 10.), 4.)));

  vec4 O = vec4((B[min(int(I * 8.), 8)] >> int(p.x + p.y * 5.)) & 1) *
      step(0., p.x) * step(0., p.y) * (1. - step(5., p.x)) *
      (1. - step(5., p.y));
  O.r = 0.0;
  O.b = 0.0;
  fragColor = O;
  // O = vec4(I);
}
