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

	double pNorm = 1.0;
	if (aux.i >= fractal->transformCommon.startIterationsG
			&& aux.i < fractal->transformCommon.stopIterationsG)
	{
		CVector4 lpN = fabs(z);
		double pr = fractal->transformCommon.scale2;
		lpN.x = pow(lpN.x, pr);
		lpN.y = pow(lpN.y, pr);
		lpN.z = pow(lpN.z, pr);
		pNorm = pow((lpN.x + lpN.y + lpN.z), 1.0 / pr);

		pNorm = pow(pNorm, fractal->transformCommon.scaleA2);
		pNorm = max(pNorm, fractal->transformCommon.offset02);

		double useScale = fractal->transformCommon.scale1p1 - aux.actualScaleA;
		if (fractal->transformCommon.functionEnabledKFalse) // update actualScaleA
			aux.actualScaleA = fractal->transformCommon.scaleVary0
										* (fabs(aux.actualScaleA) + 1.0);
		pNorm = useScale / pNorm;
		z *= pNorm;
		aux.DE *= fabs(pNorm);
	}


}
