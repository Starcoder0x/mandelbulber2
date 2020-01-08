/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.         ______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,      / ____/ __    __
 *                                        \><||i|=>>%)     / /   __/ /___/ /_
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    / /__ /_  __/_  __/
 * The project is licensed under GPLv3,   -<>>=|><|||`    \____/ /_/   /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Add exp2(z)
 * z vector version  and the xyz axis version can be used together
 */

#include "fractal_definitions.h"

cFractalTransfAddExp2Z::cFractalTransfAddExp2Z() : cAbstractFractal()
{
	nameInComboBox = "T>Add exp2(z)";
	internalName = "transf_add_exp2_z";
	internalID = fractal::transfAddExp2Z;
	DEType = analyticDEType;
	DEFunctionType = withoutDEFunction;
	cpixelAddition = cpixelDisabledByDefault;
	defaultBailout = 100.0;
	DEAnalyticFunction = analyticFunctionNone;
	coloringFunction = coloringFunctionDefault;
}

void cFractalTransfAddExp2Z::FormulaCode(CVector4 &z, const sFractal *fractal, sExtendedAux &aux)
{
	CVector4 tempZ = z;

	if (fractal->transformCommon.functionEnabledx)
	{
		if (fractal->transformCommon.functionEnabledAx)
		{
			tempZ.x = fabs(z.x);
			tempZ.x = exp2(tempZ.x * -fractal->transformCommon.constantMultiplier000.x) - 1.0;
			z.x += sign(z.x) * tempZ.x;
		}
		else if (fractal->transformCommon.functionEnabledAxFalse)
		{
			tempZ.x = fabs(z.x);
			tempZ.x = exp2(tempZ.x * -fractal->transformCommon.constantMultiplier000.x) - 1.0;
			z.x -= sign(z.x) * tempZ.x;
		}
		else // no fabs
			z.x += exp2(tempZ.x * fractal->transformCommon.constantMultiplier000.x) - 1.0;
	}

	if (fractal->transformCommon.functionEnabledy)
	{
		if (fractal->transformCommon.functionEnabledAy)
		{
			tempZ.y = fabs(z.y);
			tempZ.y = exp2(tempZ.y * -fractal->transformCommon.constantMultiplier000.y) - 1.0;
			z.y += sign(z.y) * tempZ.y;
		}
		else if (fractal->transformCommon.functionEnabledAyFalse)
		{
			tempZ.y = fabs(z.y);
			tempZ.y = exp2(tempZ.y * -fractal->transformCommon.constantMultiplier000.y) - 1.0;
			z.y -= sign(z.y) * tempZ.y;
		}
		else
			z.y += exp2(tempZ.y * fractal->transformCommon.constantMultiplier000.y) - 1.0;
	}

	if (fractal->transformCommon.functionEnabledz)
	{
		if (fractal->transformCommon.functionEnabledAz)
		{
			tempZ.z = fabs(z.z);
			tempZ.z = exp2(tempZ.z * -fractal->transformCommon.constantMultiplier000.z) - 1.0;
			z.z += sign(z.z) * tempZ.z;
		}
		else if (fractal->transformCommon.functionEnabledAzFalse)
		{
			tempZ.z = fabs(z.z);
			tempZ.z = exp2(tempZ.z * -fractal->transformCommon.constantMultiplier000.z) - 1.0;
			z.z -= sign(z.z) * tempZ.z;
		}
		else
			z.z += exp2(tempZ.z * fractal->transformCommon.constantMultiplier000.z) - 1.0;
	}

	// vector z version
	if (fractal->transformCommon.functionEnabledBzFalse)
	{
		CVector4 tempS;
		if (fractal->transformCommon.functionEnabled)
		{
			tempS = fabs(z);
			CVector4 tempT = tempS * -fractal->transformCommon.scale0;
			tempS.x = exp2(tempT.x) - 1.0;
			tempS.y = exp2(tempT.y) - 1.0;
			tempS.z = exp2(tempT.z) - 1.0;

			z.x += sign(z.x) * tempS.x;
			z.y += sign(z.y) * tempS.y;
			z.z += sign(z.z) * tempS.z;
		}
		else if (fractal->transformCommon.functionEnabledFalse)
		{
			tempS = fabs(z);
			CVector4 tempT = tempS * -fractal->transformCommon.scale0;
			tempS.x = exp2(tempT.x) - 1.0;
			tempS.y = exp2(tempT.y) - 1.0;
			tempS.z = exp2(tempT.z) - 1.0;

			z.x -= sign(z.x) * tempS.x;
			z.y -= sign(z.y) * tempS.y;
			z.z -= sign(z.z) * tempS.z;
		}
		else
		{
			CVector4 tempR = z * fractal->transformCommon.scale0;
			z.x += exp2(tempR.x) - 1.0;
			z.y += exp2(tempR.y) - 1.0;
			z.z += exp2(tempR.z) - 1.0;
		}
	}
	if (fractal->transformCommon.functionEnabledByFalse)
		aux.DE = aux.DE + exp2(aux.DE * -fractal->transformCommon.scale0) - 1.0;
	aux.DE *= fractal->analyticDE.scale1; // DE tweak
}
