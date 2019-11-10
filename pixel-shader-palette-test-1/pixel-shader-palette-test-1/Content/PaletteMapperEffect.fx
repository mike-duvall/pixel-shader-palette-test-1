#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

Texture2D SpriteTexture;
sampler s0;
float epsilon = 0.0000001f;


sampler palette;

sampler2D SpriteTextureSampler = sampler_state
{
	Texture = <SpriteTexture>;
};


Texture2D TextureB;
sampler2D TextureSamplerB = sampler_state
{
    Texture = <TextureB>;
	addressU = Clamp;
	addressV = Clamp;
	mipfilter = NONE;
	minfilter = POINT;
	magfilter = POINT;    
};


struct VertexShaderOutput
{
	float4 Position : SV_POSITION;
	float4 Color : COLOR0;
	float2 TextureCoordinates : TEXCOORD0;
};


// bool colorMatches(float4 color, float red, float green, float blue) 
// {
// 	float normalizedRed = red / 255.0f;
// 	float normalizedGreen = green / 255.0f;
// 	float normalizedBlue = blue / 255.0f;

// 	float difRed = abs(color.r - normalizedRed);
// 	float difGreen = abs(color.g - normalizedGreen);	
// 	float difBlue = abs(color.b - normalizedBlue);	

// 	bool matches = false;
// 	if(color.a && difRed < epsilon && difGreen < epsilon && difBlue < epsilon)
// 		matches = true;

// 	return matches;

// }


bool colorMatches(float4 color, float red, float green, float blue) 
{
	float normalizedRed = color.r *  255.0f;
	// float normalizedGreen = color.g * 255.0f;
	// float normalizedBlue = color.b * 255.0f;

	// float difRed = abs(color.r - normalizedRed);
	// float difGreen = abs(color.g - normalizedGreen);	
	// float difBlue = abs(color.b - normalizedBlue);	

	bool matches = false;
	// if(color.a && difRed < epsilon && difGreen < epsilon && difBlue < epsilon)
	// 	matches = true;
	if( normalizedRed == red) 
		matches = true;

	return matches;

}



float4 MainPS(VertexShaderOutput input) : COLOR
{
	float4 color = tex2D(s0, input.TextureCoordinates);
	// int index = color.r * 255.0f;
	float2 paletteCoordinates = float2(0.70f, 0.5f);
	// float2 paletteCoordinates = input.TextureCoordinates;

    float4 paletteColor = tex2D(TextureSamplerB, paletteCoordinates);
    //return paletteColor;
    return float4(paletteColor.r, paletteColor.g, paletteColor.b, color.a);

	// if(color.a && colorMatches(color, 0,0,0))
	// {
	// 	color.r = 117.0f / 255.0f;
	// 	color.g = 137.0f / 255.0f;
	// 	color.b = 255.0f / 255.0f;
	// }
	// if(color.a && colorMatches(color, 1,0,0))
	// {
	// 	color.r = 255.0f / 255.0f;
	// 	color.g = 109.0f / 255.0f;
	// 	color.b = 145.0f / 255.0f;
	// }
	// if(color.a && colorMatches(color, 2,0,0))
	// {
	// 	color.r = 251.0f / 255.0f;
	// 	color.g = 255.0f / 255.0f;
	// 	color.b = 175.0f / 255.0f;
	// }
	// if(color.a && colorMatches(color, 3,0,0))
	// {
	// 	color.r = 96.0f / 255.0f;
	// 	color.g = 255.0f / 255.0f;
	// 	color.b = 128.0f / 255.0f;
	// }

	
 //  	return color;

}


// float4 MainPS(VertexShaderOutput input) : COLOR
// {
// 	return tex2D(SpriteTextureSampler,input.TextureCoordinates) * input.Color;
// }

technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL MainPS();
	}
};