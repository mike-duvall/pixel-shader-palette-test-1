#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

Texture2D SpriteTexture;
sampler2D SpriteTextureSampler = sampler_state
{
	Texture = <SpriteTexture>;
};


Texture2D PaletteTexture;
sampler2D PaletteTextureSampler = sampler_state
{
    Texture = <PaletteTexture>;
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




float4 MainPS(VertexShaderOutput input) : COLOR
{
	float4 color = tex2D(SpriteTextureSampler, input.TextureCoordinates);
	if(color.a) {
		int numPaletteEntries = 4.0f;
		float paletteIndex = (color.r * 255.0f) / numPaletteEntries;
		float2 paletteCoordinates = float2(paletteIndex, 0.5f);

	    float4 paletteColor = tex2D(PaletteTextureSampler, paletteCoordinates);
	    return paletteColor;
	}

	return color;

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