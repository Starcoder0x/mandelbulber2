/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Formula based on Mandelbox (ABox). Extended to 4 dimensions and with variable scale parameter.
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 MandelboxVaryScale4dIteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->actualScale = mad(
		(fabs(aux->actualScale) - 1.0f), fractal->mandelboxVary4D.scaleVary, fractal->mandelbox.scale);

	float paraAddP0 = 0.0f;
	if (fractal->Cpara.enabledParabFalse)
	{ // parabolic = paraOffset + iter *slope + (iter *iter *scale)
		paraAddP0 = fractal->Cpara.parabOffset0 + (aux->i * fractal->Cpara.parabSlope)
								+ (aux->i * aux->i * 0.001f * fractal->Cpara.parabScale);
		z.w += paraAddP0;
	}

	float4 oldZ = z;
	z.x = fabs(z.x + fractal->mandelboxVary4D.fold) - fabs(z.x - fractal->mandelboxVary4D.fold) - z.x;
	z.y = fabs(z.y + fractal->mandelboxVary4D.fold) - fabs(z.y - fractal->mandelboxVary4D.fold) - z.y;
	z.z = fabs(z.z + fractal->mandelboxVary4D.fold) - fabs(z.z - fractal->mandelboxVary4D.fold) - z.z;
	z.w = fabs(z.w + fractal->mandelboxVary4D.fold) - fabs(z.w - fractal->mandelboxVary4D.fold) - z.w;

	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor4D.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor4D.y;
	if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor4D.z;
	if (z.w != oldZ.w) aux->color += fractal->mandelbox.color.factor4D.w;

	float rr =
		native_powr(z.x * z.x + mad(z.y, z.y, z.z * z.z) + z.w * z.w, fractal->mandelboxVary4D.rPower);
	float m = aux->actualScale;
	if (rr < fractal->mandelboxVary4D.minR * fractal->mandelboxVary4D.minR)
	{
		m = native_divide(
			aux->actualScale, (fractal->mandelboxVary4D.minR * fractal->mandelboxVary4D.minR));
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < 1.0f)
	{
		m = native_divide(aux->actualScale, rr);
		aux->color += fractal->mandelbox.color.factorSp2;
	}
	z *= m;
	aux->DE = mad(aux->DE, fabs(m), 1.0f);

	// 6 plane rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		float4 tp;
		if (fractal->transformCommon.rotation44a.x != 0)
		{
			tp = z;
			float alpha = fractal->transformCommon.rotation44a.x * M_PI_180;
			z.x = mad(tp.x, native_cos(alpha), tp.y * native_sin(alpha));
			z.y = tp.x * -native_sin(alpha) + tp.y * native_cos(alpha);
		}
		if (fractal->transformCommon.rotation44a.y != 0)
		{
			tp = z;
			float beta = fractal->transformCommon.rotation44a.y * M_PI_180;
			z.y = mad(tp.y, native_cos(beta), tp.z * native_sin(beta));
			z.z = tp.y * -native_sin(beta) + tp.z * native_cos(beta);
		}
		if (fractal->transformCommon.rotation44a.z != 0)
		{
			tp = z;
			float gamma = fractal->transformCommon.rotation44a.z * M_PI_180;
			z.x = mad(tp.x, native_cos(gamma), tp.z * native_sin(gamma));
			z.z = tp.x * -native_sin(gamma) + tp.z * native_cos(gamma);
		}
		if (fractal->transformCommon.rotation44b.x != 0)
		{
			tp = z;
			float delta = fractal->transformCommon.rotation44b.x * M_PI_180;
			z.x = mad(tp.x, native_cos(delta), tp.w * native_sin(delta));
			z.w = tp.x * -native_sin(delta) + tp.w * native_cos(delta);
		}
		if (fractal->transformCommon.rotation44b.y != 0)
		{
			tp = z;
			float epsilon = fractal->transformCommon.rotation44b.y * M_PI_180;
			z.y = mad(tp.y, native_cos(epsilon), tp.w * native_sin(epsilon));
			z.w = tp.y * -native_sin(epsilon) + tp.w * native_cos(epsilon);
		}
		if (fractal->transformCommon.rotation44b.z != 0)
		{
			tp = z;
			float zeta = fractal->transformCommon.rotation44b.z * M_PI_180;
			z.z = mad(tp.z, native_cos(zeta), tp.w * native_sin(zeta));
			z.w = tp.z * -native_sin(zeta) + tp.w * native_cos(zeta);
		}
	}
	return z;
}
#else
double4 MandelboxVaryScale4dIteration(
	double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->actualScale = mad(
		(fabs(aux->actualScale) - 1.0), fractal->mandelboxVary4D.scaleVary, fractal->mandelbox.scale);

	double paraAddP0 = 0.0;
	if (fractal->Cpara.enabledParabFalse)
	{ // parabolic = paraOffset + iter *slope + (iter *iter *scale)
		paraAddP0 = fractal->Cpara.parabOffset0 + (aux->i * fractal->Cpara.parabSlope)
								+ (aux->i * aux->i * 0.001 * fractal->Cpara.parabScale);
		z.w += paraAddP0;
	}

	double4 oldZ = z;
	z.x = fabs(z.x + fractal->mandelboxVary4D.fold) - fabs(z.x - fractal->mandelboxVary4D.fold) - z.x;
	z.y = fabs(z.y + fractal->mandelboxVary4D.fold) - fabs(z.y - fractal->mandelboxVary4D.fold) - z.y;
	z.z = fabs(z.z + fractal->mandelboxVary4D.fold) - fabs(z.z - fractal->mandelboxVary4D.fold) - z.z;
	z.w = fabs(z.w + fractal->mandelboxVary4D.fold) - fabs(z.w - fractal->mandelboxVary4D.fold) - z.w;

	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor4D.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor4D.y;
	if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor4D.z;
	if (z.w != oldZ.w) aux->color += fractal->mandelbox.color.factor4D.w;

	double rr =
		native_powr(z.x * z.x + mad(z.y, z.y, z.z * z.z) + z.w * z.w, fractal->mandelboxVary4D.rPower);
	double m = aux->actualScale;
	if (rr < fractal->mandelboxVary4D.minR * fractal->mandelboxVary4D.minR)
	{
		m = native_divide(
			aux->actualScale, (fractal->mandelboxVary4D.minR * fractal->mandelboxVary4D.minR));
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < 1.0)
	{
		m = native_divide(aux->actualScale, rr);
		aux->color += fractal->mandelbox.color.factorSp2;
	}
	z *= m;
	aux->DE = aux->DE * fabs(m) + 1.0;

	// 6 plane rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		double4 tp;
		if (fractal->transformCommon.rotation44a.x != 0)
		{
			tp = z;
			double alpha = fractal->transformCommon.rotation44a.x * M_PI_180;
			z.x = mad(tp.x, native_cos(alpha), tp.y * native_sin(alpha));
			z.y = tp.x * -native_sin(alpha) + tp.y * native_cos(alpha);
		}
		if (fractal->transformCommon.rotation44a.y != 0)
		{
			tp = z;
			double beta = fractal->transformCommon.rotation44a.y * M_PI_180;
			z.y = mad(tp.y, native_cos(beta), tp.z * native_sin(beta));
			z.z = tp.y * -native_sin(beta) + tp.z * native_cos(beta);
		}
		if (fractal->transformCommon.rotation44a.z != 0)
		{
			tp = z;
			double gamma = fractal->transformCommon.rotation44a.z * M_PI_180;
			z.x = mad(tp.x, native_cos(gamma), tp.z * native_sin(gamma));
			z.z = tp.x * -native_sin(gamma) + tp.z * native_cos(gamma);
		}
		if (fractal->transformCommon.rotation44b.x != 0)
		{
			tp = z;
			double delta = fractal->transformCommon.rotation44b.x * M_PI_180;
			z.x = mad(tp.x, native_cos(delta), tp.w * native_sin(delta));
			z.w = tp.x * -native_sin(delta) + tp.w * native_cos(delta);
		}
		if (fractal->transformCommon.rotation44b.y != 0)
		{
			tp = z;
			double epsilon = fractal->transformCommon.rotation44b.y * M_PI_180;
			z.y = mad(tp.y, native_cos(epsilon), tp.w * native_sin(epsilon));
			z.w = tp.y * -native_sin(epsilon) + tp.w * native_cos(epsilon);
		}
		if (fractal->transformCommon.rotation44b.z != 0)
		{
			tp = z;
			double zeta = fractal->transformCommon.rotation44b.z * M_PI_180;
			z.z = mad(tp.z, native_cos(zeta), tp.w * native_sin(zeta));
			z.w = tp.z * -native_sin(zeta) + tp.w * native_cos(zeta);
		}
	}
	return z;
}
#endif
