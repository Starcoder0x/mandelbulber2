/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * amazing surf from Mandelbulber3D. Formula proposed by Kali, with features added by Darkbeam
 *
 * This formula has a c.x c.y SWAP
 *
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 AmazingSurfIteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// update aux->actualScale
	aux->actualScale = mad(
		(fabs(aux->actualScale) - 1.0f), fractal->mandelboxVary4D.scaleVary, fractal->mandelbox.scale);

	float4 c = aux->const_c;
	float4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
				- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
				- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
	// no z fold
	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor4D.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor4D.y;

	float rr = dot(z, z);
	if (fractal->transformCommon.functionEnabledFalse) // force cylinder fold
		rr -= z.z * z.z;

	float sqrtMinR = native_sqrt(fractal->transformCommon.minR05);
	float dividend = rr < sqrtMinR ? sqrtMinR : min(rr, 1.0f);

	/*if (rr < sqrtMinR)
	{
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < 1.0f)
	{
		aux->color += fractal->mandelbox.color.factorSp2;
	}*/
	// use aux->actualScale
	float m = native_divide(aux->actualScale, dividend);

	z *= mad((m - 1.0f), fractal->transformCommon.scale1, 1.0f);
	// z *= mad(m, fractal->transformCommon.scale1, 1.0f * (1.0f - fractal->transformCommon.scale1));
	aux->DE = mad(aux->DE, fabs(m), 1.0f);

	if (fractal->transformCommon.addCpixelEnabledFalse)
		z += (float4){c.y, c.x, c.z, c.w} * fractal->transformCommon.constantMultiplier111;

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	return z;
}
#else
double4 AmazingSurfIteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// update aux->actualScale
	aux->actualScale = mad(
		(fabs(aux->actualScale) - 1.0), fractal->mandelboxVary4D.scaleVary, fractal->mandelbox.scale);

	double4 c = aux->const_c;
	double4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
				- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
				- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
	// no z fold
	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor4D.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor4D.y;

	double rr = dot(z, z);
	if (fractal->transformCommon.functionEnabledFalse) // force cylinder fold
		rr -= z.z * z.z;

	double sqrtMinR = native_sqrt(fractal->transformCommon.minR05);
	double dividend = rr < sqrtMinR ? sqrtMinR : min(rr, 1.0);

	/*if (rr < sqrtMinR)
	{
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < 1.0)
	{
		aux->color += fractal->mandelbox.color.factorSp2;
	}*/
	// use aux->actualScale
	double m = native_divide(aux->actualScale, dividend);

	z *= (m - 1.0) * fractal->transformCommon.scale1 + 1.0;
	// z *= m * fractal->transformCommon.scale1 + 1.0 * (1.0 - fractal->transformCommon.scale1);
	aux->DE = aux->DE * fabs(m) + 1.0;

	if (fractal->transformCommon.addCpixelEnabledFalse)
		z += (double4){c.y, c.x, c.z, c.w} * fractal->transformCommon.constantMultiplier111;

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	return z;
}
#endif
