struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    @location(0) coord: vec2<f32>,
};

struct Uniforms {
    mouse: vec2<f32>,
    time: f32,
    _pad: f32,
    window_size: vec2<f32>,
};

@group(0) @binding(0)
var<uniform> uniforms: Uniforms;

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let aspect = uniforms.window_size.xy * 2.0 / uniforms.window_size.y;
    let normalized = (in.coord * aspect + vec2<f32>(1., 1.)) / 2.;
    let r = 0.25 + 0.25 * sin(uniforms.time);
    let delta = abs(uniforms.mouse * aspect - in.coord * aspect - vec2<f32>(r/2., r/2.)) % vec2<f32>(r, r) - vec2<f32>(r / 2., r / 2.);
    let c = dot(delta, delta);
    
    if (c > (r / 100.)) {
        discard;
    }

    return vec4<f32>(1.0, normalized.rg, 1.0);
}
