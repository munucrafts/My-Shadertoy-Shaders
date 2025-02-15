#define PI 3.14159265359

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord.xy / iResolution.xy) - 0.5; 
    uv.x *= iResolution.x / iResolution.y;  
    
    float angle = atan(uv.y, uv.x);  
    float radius = length(uv);  
    float rays = 70.0;  

    float rayPattern = smoothstep(0.25, 0.5, sin(angle * rays + iTime * 5.0));  

    float glow = exp(-radius * 10.0);  

    float core = smoothstep(0.5, 0.3, radius);  

    vec3 sunColor = mix(vec3(1.0, 0.5, 0.0), vec3(0.0, 1.0, 1.0), sin(iTime * 0.5) * 0.5 + 0.5);

    vec3 color = sunColor * (rayPattern + glow) * core;

    fragColor = vec4(color, 1.0);
}
