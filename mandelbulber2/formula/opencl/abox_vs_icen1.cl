/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * ABoxVS_icen1, a formula from Mandelbulb3D.
 * Inspired from a 2D formula proposed by Kali at Fractal Forums
 * @reference
 * http://www.fractalforums.com/new-theories-and-research/kaliset-plus-boxfold-nice-new-2d-fractal/msg33670/#new
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 AboxVSIcen1Iteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->actualScale = fractal->mandelboxVary4D.scaleVary * (fabs(aux->actualScale) - 1.0f);
	float4 c = aux->const_c;
	float4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
				- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
				- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
	z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
				- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;
	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor4D.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor4D.y;
	if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor4D.z;
	if (fractal->transformCommon.juliaMode)
	{
		z += c * fractal->transformCommon.constantMultiplier111;
	}
	else
	{
		z += fractal->transformCommon.juliaC;
	}

	float r2 = dot(z, z);
	// if (r2 < 1e-21f && r2 > -1e-21f)
	//	r2 = (r2 > 0) ? 1e-21f : -1e-21f;
	if (r2 < fractal->mandelbox.mR2)
	{
		z *= fractal->mandelbox.mboxFactor1;
		aux->DE *= fractal->mandelbox.mboxFactor1;
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (r2 < fractal->mandelbox.fR2)
	{
		float tglad_factor2 = native_divide(fractal->mandelbox.fR2, r2);
		z *= tglad_factor2;
		aux->DE *= tglad_factor2;
		aux->color += fractal->mandelbox.color.factorSp2;
	}

	z *= aux->actualScale;
	aux->DE = mad(aux->DE, fabs(aux->actualScale), 1.0f);

	if (fractal->transformCommon.juliaMode)
	{
		z += mad(-fractal->transformCommon.constantMultiplier111, c, fractal->transformCommon.juliaC);
	}
	else
	{
		z += mad(c, fractal->transformCommon.constantMultiplier111, fractal->transformCommon.juliaC);
	}
	return z;
}
#else
double4 AboxVSIcen1Iteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->actualScale = fractal->mandelboxVary4D.scaleVary * (fabs(aux->actualScale) - 1.0);
	double4 c = aux->const_c;
	double4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
				- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
				- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
	z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
				- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;
	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor4D.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor4D.y;
	if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor4D.z;
	if (fractal->transformCommon.juliaMode)
	{
		z += c * fractal->transformCommon.constantMultiplier111;
	}
	else
	{
		z += fractal->transformCommon.juliaC;
	}

	double r2 = dot(z, z);
	// if (r2 < 1e-21 && r2 > -1e-21)
	//	r2 = (r2 > 0) ? 1e-21 : -1e-21;
	if (r2 < fractal->mandelbox.mR2)
	{
		z *= fractal->mandelbox.mboxFactor1;
		aux->DE *= fractal->mandelbox.mboxFactor1;
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (r2 < fractal->mandelbox.fR2)
	{
		double tglad_factor2 = native_divide(fractal->mandelbox.fR2, r2);
		z *= tglad_factor2;
		aux->DE *= tglad_factor2;
		aux->color += fractal->mandelbox.color.factorSp2;
	}

	z *= aux->actualScale;
	aux->DE = aux->DE * fabs(aux->actualScale) + 1.0;

	if (fractal->transformCommon.juliaMode)
	{
		z += mad(-fractal->transformCommon.constantMultiplier111, c, fractal->transformCommon.juliaC);
	}
	else
	{
		z += mad(c, fractal->transformCommon.constantMultiplier111, fractal->transformCommon.juliaC);
	}
	return z;
}
#endif
