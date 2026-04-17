#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <minecraft:dynamictransforms.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec2 texCoord0;

out vec4 fragColor;

const int WIDTH = 1024;
const int HEIGHT = 512;
const int SCALE = 1;

void main() {
    vec2 adjTexCoord0 = (TextureMat * vec4(floor(WIDTH * texCoord0.x) / WIDTH * SCALE, floor(HEIGHT * texCoord0.y) / HEIGHT * SCALE, 0.0, 1.0)).xy;
    vec4 color = texture(Sampler0, adjTexCoord0) * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    float fade = (1.0f - total_fog_value(sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd)) * GlintAlpha;
    fragColor = vec4(color.rgb * fade, color.a);
}
