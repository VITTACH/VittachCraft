attribute vec3 a_position;
attribute vec2 a_texCoord0;
attribute vec3 a_normal;

uniform mat4 u_chunkTrans;
uniform mat4 u_projViewTrans;
uniform mat3 u_normalMatrix;
uniform mat4 u_lightTrans;

varying vec2 v_texCoords0;
varying float v_intensity;
varying vec4 v_positionLightTrans;
varying vec4 v_position;

void main() {
    v_position = u_chunkTrans * vec4(a_position, 1.0);
    v_positionLightTrans = u_lightTrans * v_position;
    gl_Position = u_projViewTrans * v_position;

    v_texCoords0 = a_texCoord0;

    // Just add some basic self shadow
    vec3 normal = normalize(u_normalMatrix * a_normal);
    v_intensity = 1.0;
    if (normal.y < 0.5) {
        if (normal.x > 0.5 || normal.x < -0.5) {
            v_intensity *= 0.8;
        }
        if (normal.z > 0.5 || normal.z < -0.5) {
            v_intensity *= 0.6;
        }
    }
}