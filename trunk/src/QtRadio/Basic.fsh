uniform sampler2D spectrumTexture;
uniform float cy;
uniform float offset;
uniform float waterfallLow, waterfallHigh;

void main()
{

  float y_coord = gl_TexCoord[0].t + cy;
  if (y_coord > 1.0) y_coord -= 1.0;
  float x_coord = gl_TexCoord[0].s;
  if (x_coord > 1.0) x_coord -= 1.0;
  if (x_coord < 0.0) x_coord += 1.0;
  vec4 value = texture2D(spectrumTexture, vec2(x_coord, y_coord));
  float sample = 1.0 - value.r;

  float percent = (sample - 0.4) * 1.5;
  if (percent < 0.0) percent = 0.0;
  if (percent > 1.0) percent = 1.0;

  vec4 texel;

  if (percent < (2.0/9.0)) {texel = vec4(0.0, 0.0, percent/(2.0/9.0), 1.0);}
  else if (percent < (3.0/9.0)) {texel = vec4(0.0, (percent - (2.0/9.0))/(1.0/9.0), 1.0, 1.0);}
  else if (percent < (4.0/9.0)) {
	float local_percent = (percent - (3.0/9.0))/(1.0/9.0);
	texel = vec4(0.0, (1.0 - local_percent), 1.0, 1.0);
  }
  else if (percent < (5.0/9.0)) {texel = vec4((percent - (4.0/9.0))/(1.0/9.0), 1.0, 0.0, 1.0);}
  else if (percent < (7.0/9.0)) {
	float local_percent = (percent - (5.0/9.0))/(2.0/9.0);
	texel = vec4(1.0, (1.0 - local_percent), 0.0, 1.0);
  }
  else if (percent < (8.0/9.0)){ texel = vec4(1.0, 0.0, (percent - (7.0/9.0))/(1.0/9.0), 1.0);}
  else {
	float local_percent = (percent - 8.0/9.0)/(1.0/9.0);
	texel = vec4(0.75+0.25*(1.0-local_percent), 0.5*local_percent, 1.0, 1.0);
  }

  gl_FragColor = texel;
}