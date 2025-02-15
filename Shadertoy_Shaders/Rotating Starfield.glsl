#define PI 3.1415

float RandFloat(vec2 p) 
{
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

mat2 Rotate(float angle)
{
    float c = cos(angle);
    float s = sin(angle);
    return mat2(c, -s, s, c);
}

float Star(vec2 uv, float shine, float size) 
{
    uv /= 2.0 * size;
    float d = length(uv);
    
    float x = abs(uv.x);
    float y = abs(uv.y);
    float m = max(0.0, 1.0 - (x * y * 1000.0));
    m *= shine;
    
    uv *= Rotate(PI / 4.0);
    x = abs(uv.x);
    y = abs(uv.y);
    float r = max(0.0, 1.0 - (x * y * 1000.0));
    r *= shine;
    
    m *= smoothstep(1.0, 0.01, d);
    r *= smoothstep(1.0, 0.1, d);
    
    return r + m + (0.02 / d);
}

vec3 SpawnStars(vec2 uv)
{
	vec3 col = vec3(0);
	
    vec2 gv = fract(uv)-0.5;
    vec2 id = floor(uv);
    
    for(int y = -1; y <= 1; y++) 
    {
    	for(int x = -1; x <= 1; x++) 
        {
            vec2 offs = vec2(x, y);
            
    		float n = RandFloat(id + offs);
            float size = fract(n * 385.32);
            
    		float star = Star(gv - offs - vec2(n, fract(n * 34.0)) + 0.5, smoothstep(0.9, 1.0, size), size);
            
            vec3 color = sin(vec3(0.2, 0.3, 0.9) * fract(n * 875.2) * 123.2) * 0.5 + 0.5;
            color = color * vec3(1.0, 0.25, 1.0 + size)+vec3(0.2, 0.2, 0.1) * 2.0;
            
            star *= sin(iTime * 3.0 + n * 2.0 * PI) * 0.5 + 1.0;
            col += star * size * color;
        }
    }
    return col; 
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
	vec2 M = (iMouse.xy - iResolution.xy * 0.5) / iResolution.y;
    
    float t = iTime * 0.02;
    
    uv += M * 4.0;
    
    uv *= Rotate(t);
    vec3 col = vec3(0);
    
    for(float i = 0.0; i < 1.0; i += 1.0/5.0) 
    {
    	float depth = fract(i + t);
        
        float scale = mix(20.0, 0.5, depth);
        float fade = depth*smoothstep(1.0, 0.9, depth);
        col += SpawnStars(uv * scale + i * 453.2 - M) * fade;
    }
    
    col = pow(col, vec3(1.4545));
    
    fragColor = vec4(col,1.0);
}
