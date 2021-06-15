/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.         ______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,      / ____/ __    __
 *                                        \><||i|=>>%)     / /   __/ /___/ /_
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    / /__ /_  __/_  __/
 * The project is licensed under GPLv3,   -<>>=|><|||`    \____/ /_/   /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Based on a DarkBeam fold formula adapted by Knighty
 * MandalayBox  Fragmentarium /Examples/ Knighty Collection
 */

#include "all_fractal_definitions.h"

cFractalTestingTransform::cFractalTestingTransform() : cAbstractFractal()
{
	nameInComboBox = "Testing Transform";
	internalName = "testing_transform";
	internalID = fractal::testingTransform;
	DEType = analyticDEType;
	DEFunctionType = linearDEFunction;
	cpixelAddition = cpixelEnabledByDefault;
	defaultBailout = 100.0;
	DEAnalyticFunction = analyticFunctionLinear;
	coloringFunction = coloringFunctionDefault;
}

void cFractalTestingTransform::FormulaCode(CVector4 &z, const sFractal *fractal, sExtendedAux &aux)
{
	//CVector4 lpN = fabs(z);
	CVector4 lpN = z;
	lpN = fabs(lpN);
	double pr = fractal->transformCommon.scale2;
	lpN.x = pow(lpN.x, pr);
	lpN.y = pow(lpN.y, pr);
	lpN.z = pow(lpN.z, pr);

	double pNorm = lpN.x + lpN.y + lpN.z;
	//if (fractal->transformCommon.functionEnabledFalse) pNorm += pow(lpN.w, pr);
	//pNorm = pow(pNorm, 1.0 / pr);

	pNorm = pow(pNorm, fractal->transformCommon.scaleA2);
	//pNorm = max(pNorm, fractal->transformCommon.offset0);

	double rr = pNorm;

	double useScale = fractal->transformCommon.scale1 - aux.actualScaleA;
	if (fractal->transformCommon.functionEnabledKFalse) // update actualScaleA
		aux.actualScaleA = fractal->transformCommon.scaleVary0
									* (fabs(aux.actualScaleA) + 1.0);
	pNorm = useScale / pNorm;


	//double rr = z.Dot(z);
	z += fractal->transformCommon.offset000;
	double minR = fractal->transformCommon.minR0;
	if (rr < minR)
	{
		z *= useScale / minR ;
		aux.DE *= useScale / minR ;
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			aux.color += fractal->mandelbox.color.factorSp1;
		}
	}
	else if (rr < 1.0)
	{
		z *= pNorm;
		aux.DE *= pNorm;
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			aux.color += fractal->mandelbox.color.factorSp2;
		}
	}
	z -= fractal->transformCommon.offset000;









	if (fractal->analyticDE.enabledFalse)
		aux.DE = aux.DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
}
