<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http:webassign.com"
    exclude-result-prefixes="xs fn"
    version="2.0">
    
    <xsl:output 
        doctype-public="-//OASIS//DTD DITA 1.1 Reference//EN"
        doctype-system="http://docs.oasis-open.org/dita/v1.1/OS/dtd/reference.dtd" 
        xml:space="preserve"/>
    
    <xsl:variable name="knownIDs">
        <symbol id="0arrow"/>
        <symbol id="0hat"/>
        <symbol id="AElig"/>
        <symbol id="Aacute" table="A" row="100"/>
        <symbol id="Aarrow" table="A" row="250"/>
        <symbol id="Aarrowbold" table="A" row="260"/>
        <symbol id="Aarrowbolditalic" table="A" row="280"/>
        <symbol id="Aarrowitalic" table="A" row="270"/>
        <symbol id="Abar" table="A" row="200"/>
        <symbol id="Abarbold" table="A" row="210"/>
        <symbol id="Abarbolditalic" table="A" row="230"/>
        <symbol id="Abaritalic" table="A" row="220"/>
        <symbol id="Acirc"/>
        <symbol id="Agrave" table="A" row="110"/>
        <symbol id="Ahat" table="A" row="160"/>
        <symbol id="Ahatbold" table="A" row="170"/>
        <symbol id="Ahatbolditalic" table="A" row="190"/>
        <symbol id="Ahatitalic" table="A" row="180"/>
        <symbol id="Alpha"/>
        <symbol id="Alpha2"/>
        <symbol id="Alphabar"/>
        <symbol id="Alphadbldot"/>
        <symbol id="Alphadot"/>
        <symbol id="Alphahat"/>
        <symbol id="Alphavec"/>
        <symbol id="Angstrom"/>
        <symbol id="Aring"/>
        <symbol id="Atilde" table="A" row="150"/>
        <symbol id="Auml" table="A" row="120"/>
        <symbol id="Avec" table="A" row="290"/>
        <symbol id="Avecbold" table="A" row="300"/>
        <symbol id="Avecbolditalic" table="A" row="320"/>
        <symbol id="Avecitalic" table="A" row="310"/>
        <symbol id="Barrow" table="B" row="250"/>
        <symbol id="Barrowbold" table="B" row="260"/>
        <symbol id="Barrowbolditalic" table="B" row="280"/>
        <symbol id="Barrowitalic" table="B" row="270"/>
        <symbol id="Bbar" table="B" row="200"/>
        <symbol id="Bbarbold" table="B" row="210"/>
        <symbol id="Bbarbolditalic" table="B" row="230"/>
        <symbol id="Bbaritalic" table="B" row="220"/>
        <symbol id="Beta"/>
        <symbol id="Beta2"/>
        <symbol id="Betabar"/>
        <symbol id="Betadbldot"/>
        <symbol id="Betadot"/>
        <symbol id="Betahat"/>
        <symbol id="Betavec"/>
        <symbol id="Bhat" table="B" row="160"/>
        <symbol id="Bhatbold" table="B" row="170"/>
        <symbol id="Bhatbolditalic" table="B" row="190"/>
        <symbol id="Bhatitalic" table="B" row="180"/>
        <symbol id="Btilde" table="B" row="150"/>
        <symbol id="Bvec" table="B" row="290"/>
        <symbol id="Bvecbold" table="B" row="300"/>
        <symbol id="Bvecbolditalic" table="B" row="320"/>
        <symbol id="Bvecitalic" table="B" row="310"/>
        <symbol id="Carrow" table="C" row="250"/>
        <symbol id="Carrowbold" table="C" row="260"/>
        <symbol id="Carrowbolditalic" table="C" row="280"/>
        <symbol id="Carrowitalic" table="C" row="270"/>
        <symbol id="Cbar" table="C" row="200"/>
        <symbol id="Cbarbold" table="C" row="210"/>
        <symbol id="Cbarbolditalic" table="C" row="230"/>
        <symbol id="Cbaritalic" table="C" row="220"/>
        <symbol id="Ccedil"/>
        <symbol id="Chat" table="C" row="160"/>
        <symbol id="Chatbold" table="C" row="170"/>
        <symbol id="Chatbolditalic" table="C" row="190"/>
        <symbol id="Chatitalic" table="C" row="180"/>
        <symbol id="Chi"/>
        <symbol id="Chi2"/>
        <symbol id="Chibar"/>
        <symbol id="Chidbldot"/>
        <symbol id="Chidot"/>
        <symbol id="Chihat"/>
        <symbol id="Chivec"/>
        <symbol id="Ctilde" table="C" row="150"/>
        <symbol id="Cvec" table="C" row="290"/>
        <symbol id="Cvecbold" table="C" row="300"/>
        <symbol id="Cvecbolditalic" table="C" row="320"/>
        <symbol id="Cvecitalic" table="C" row="310"/>
        <symbol id="Darrow" table="D" row="250"/>
        <symbol id="Darrowbold" table="D" row="260"/>
        <symbol id="Darrowbolditalic" table="D" row="280"/>
        <symbol id="Darrowitalic" table="D" row="270"/>
        <symbol id="Dbar" table="D" row="200"/>
        <symbol id="Dbarbold" table="D" row="210"/>
        <symbol id="Dbarbolditalic" table="D" row="230"/>
        <symbol id="Dbaritalic" table="D" row="220"/>
        <symbol id="Delta"/>
        <symbol id="Delta2"/>
        <symbol id="Deltabar"/>
        <symbol id="Deltadbldot"/>
        <symbol id="Deltadot"/>
        <symbol id="Deltahat"/>
        <symbol id="Deltavec"/>
        <symbol id="Dhat" table="D" row="160"/>
        <symbol id="Dhatbold" table="D" row="170"/>
        <symbol id="Dhatbolditalic" table="D" row="190"/>
        <symbol id="Dhatitalic" table="D" row="180"/>
        <symbol id="Dvec" table="D" row="290"/>
        <symbol id="Dvecbold" table="D" row="300"/>
        <symbol id="Dvecbolditalic" table="D" row="320"/>
        <symbol id="Dvecitalic" table="D" row="310"/>
        <symbol id="ETH"/>
        <symbol id="Eacute" table="E" row="100"/>
        <symbol id="Earrow" table="E" row="250"/>
        <symbol id="Earrowbold" table="E" row="260"/>
        <symbol id="Earrowbolditalic" table="E" row="280"/>
        <symbol id="Earrowitalic" table="E" row="270"/>
        <symbol id="Ebar" table="E" row="200"/>
        <symbol id="Ebarbold" table="E" row="210"/>
        <symbol id="Ebarbolditalic" table="E" row="230"/>
        <symbol id="Ebaritalic" table="E" row="220"/>
        <symbol id="Ecirc"/>
        <symbol id="Egrave" table="E" row="110"/>
        <symbol id="Ehat" table="E" row="160"/>
        <symbol id="Ehatbold" table="E" row="170"/>
        <symbol id="Ehatbolditalic" table="E" row="190"/>
        <symbol id="Ehatitalic" table="E" row="180"/>
        <symbol id="Epsilon"/>
        <symbol id="Epsilon2"/>
        <symbol id="Epsilonbar"/>
        <symbol id="Epsilondbldot"/>
        <symbol id="Epsilondot"/>
        <symbol id="Epsilonhat"/>
        <symbol id="Epsilonvec"/>
        <symbol id="Eta"/>
        <symbol id="Eta2"/>
        <symbol id="Etabar"/>
        <symbol id="Etadbldot"/>
        <symbol id="Etadot"/>
        <symbol id="Etahat"/>
        <symbol id="Etavec"/>
        <symbol id="Euml" table="E" row="120"/>
        <symbol id="Evec" table="E" row="290"/>
        <symbol id="Evecbold" table="E" row="300"/>
        <symbol id="Evecbolditalic" table="E" row="320"/>
        <symbol id="Evecitalic" table="E" row="310"/>
        <symbol id="Farrow" table="F" row="250"/>
        <symbol id="Farrowbold" table="F" row="260"/>
        <symbol id="Farrowbolditalic" table="F" row="280"/>
        <symbol id="Farrowitalic" table="F" row="270"/>
        <symbol id="Fbar" table="F" row="200"/>
        <symbol id="Fbarbold" table="F" row="210"/>
        <symbol id="Fbarbolditalic" table="F" row="230"/>
        <symbol id="Fbaritalic" table="F" row="220"/>
        <symbol id="Fhat" table="F" row="160"/>
        <symbol id="Fhatbold" table="F" row="170"/>
        <symbol id="Fhatbolditalic" table="F" row="190"/>
        <symbol id="Fhatitalic" table="F" row="180"/>
        <symbol id="Fvec" table="F" row="290"/>
        <symbol id="Fvecbold" table="F" row="300"/>
        <symbol id="Fvecbolditalic" table="F" row="320"/>
        <symbol id="Fvecitalic" table="F" row="310"/>
        <symbol id="Gamma"/>
        <symbol id="Gamma2"/>
        <symbol id="Gamma_acc"/>
        <symbol id="Gammabar"/>
        <symbol id="Gammadbldot"/>
        <symbol id="Gammadot"/>
        <symbol id="Gammahat"/>
        <symbol id="Gammavec"/>
        <symbol id="Garrow" table="G" row="250"/>
        <symbol id="Garrowbold" table="G" row="260"/>
        <symbol id="Garrowbolditalic" table="G" row="280"/>
        <symbol id="Garrowitalic" table="G" row="270"/>
        <symbol id="Gbar" table="G" row="200"/>
        <symbol id="Gbarbold" table="G" row="210"/>
        <symbol id="Gbarbolditalic" table="G" row="230"/>
        <symbol id="Gbaritalic" table="G" row="220"/>
        <symbol id="Ghat" table="G" row="160"/>
        <symbol id="Ghatbold" table="G" row="170"/>
        <symbol id="Ghatbolditalic" table="G" row="190"/>
        <symbol id="Ghatitalic" table="G" row="180"/>
        <symbol id="Gvec" table="G" row="290"/>
        <symbol id="Gvecbold" table="G" row="300"/>
        <symbol id="Gvecbolditalic" table="G" row="320"/>
        <symbol id="Gvecitalic" table="G" row="310"/>
        <symbol id="H2Ortarrow"/>
        <symbol id="Harrow" table="H" row="250"/>
        <symbol id="Harrowbold" table="H" row="260"/>
        <symbol id="Harrowbolditalic" table="H" row="280"/>
        <symbol id="Harrowitalic" table="H" row="270"/>
        <symbol id="Hbar" table="H" row="200"/>
        <symbol id="Hbarbold" table="H" row="210"/>
        <symbol id="Hbarbolditalic" table="H" row="230"/>
        <symbol id="Hbaritalic" table="H" row="220"/>
        <symbol id="Hhat" table="H" row="160"/>
        <symbol id="Hhatbold" table="H" row="170"/>
        <symbol id="Hhatbolditalic" table="H" row="190"/>
        <symbol id="Hhatitalic" table="H" row="180"/>
        <symbol id="Hvec" table="H" row="290"/>
        <symbol id="Hvecbold" table="H" row="300"/>
        <symbol id="Hvecbolditalic" table="H" row="320"/>
        <symbol id="Hvecitalic" table="H" row="310"/>
        <symbol id="Iacute" table="I" row="100"/>
        <symbol id="Iarrow" table="I" row="250"/>
        <symbol id="Iarrowbold" table="I" row="260"/>
        <symbol id="Iarrowbolditalic" table="I" row="280"/>
        <symbol id="Iarrowitalic" table="I" row="270"/>
        <symbol id="Ibar" table="I" row="200"/>
        <symbol id="Ibarbold" table="I" row="210"/>
        <symbol id="Ibarbolditalic" table="I" row="230"/>
        <symbol id="Ibaritalic" table="I" row="220"/>
        <symbol id="Icirc"/>
        <symbol id="Igrave" table="I" row="110"/>
        <symbol id="Ihat" table="I" row="160"/>
        <symbol id="Ihatbold" table="I" row="170"/>
        <symbol id="Ihatbolditalic" table="I" row="190"/>
        <symbol id="Ihatitalic" table="I" row="180"/>
        <symbol id="Iota"/>
        <symbol id="Iota2"/>
        <symbol id="Iotabar"/>
        <symbol id="Iotadbldot"/>
        <symbol id="Iotadot"/>
        <symbol id="Iotahat"/>
        <symbol id="Iotavec"/>
        <symbol id="Iuml" table="I" row="120"/>
        <symbol id="Ivec" table="I" row="290"/>
        <symbol id="Ivecbold" table="I" row="300"/>
        <symbol id="Ivecbolditalic" table="I" row="320"/>
        <symbol id="Ivecitalic" table="I" row="310"/>
        <symbol id="Jarrow" table="J" row="250"/>
        <symbol id="Jarrowbold" table="J" row="260"/>
        <symbol id="Jarrowbolditalic" table="J" row="280"/>
        <symbol id="Jarrowitalic" table="J" row="270"/>
        <symbol id="Jbar" table="J" row="200"/>
        <symbol id="Jbarbold" table="J" row="210"/>
        <symbol id="Jbarbolditalic" table="J" row="230"/>
        <symbol id="Jbaritalic" table="J" row="220"/>
        <symbol id="Jhat" table="J" row="160"/>
        <symbol id="Jhatbold" table="J" row="170"/>
        <symbol id="Jhatbolditalic" table="J" row="190"/>
        <symbol id="Jhatitalic" table="J" row="180"/>
        <symbol id="Jvec" table="J" row="290"/>
        <symbol id="Jvecbold" table="J" row="300"/>
        <symbol id="Jvecbolditalic" table="J" row="320"/>
        <symbol id="Jvecitalic" table="J" row="310"/>
        <symbol id="Kappa"/>
        <symbol id="Kappa2"/>
        <symbol id="Kappabar"/>
        <symbol id="Kappadbldot"/>
        <symbol id="Kappadot"/>
        <symbol id="Kappahat"/>
        <symbol id="Kappavec"/>
        <symbol id="Karrow" table="K" row="250"/>
        <symbol id="Karrowbold" table="K" row="260"/>
        <symbol id="Karrowbolditalic" table="K" row="280"/>
        <symbol id="Karrowitalic" table="K" row="270"/>
        <symbol id="Kbar" table="K" row="200"/>
        <symbol id="Kbarbold" table="K" row="210"/>
        <symbol id="Kbarbolditalic" table="K" row="230"/>
        <symbol id="Kbaritalic" table="K" row="220"/>
        <symbol id="Khat" table="K" row="160"/>
        <symbol id="Khatbold" table="K" row="170"/>
        <symbol id="Khatbolditalic" table="K" row="190"/>
        <symbol id="Kvec" table="K" row="290"/>
        <symbol id="Kvecbold" table="K" row="300"/>
        <symbol id="Kvecbolditalic" table="K" row="320"/>
        <symbol id="Kvecitalic" table="K" row="310"/>
        <symbol id="Lambda"/>
        <symbol id="Lambda2"/>
        <symbol id="Lambdabar"/>
        <symbol id="Lambdadbldot"/>
        <symbol id="Lambdadot"/>
        <symbol id="Lambdahat"/>
        <symbol id="Lambdavec"/>
        <symbol id="Larrow" table="L" row="250"/>
        <symbol id="Larrowbold" table="L" row="260"/>
        <symbol id="Larrowbolditalic" table="L" row="280"/>
        <symbol id="Larrowitalic" table="L" row="270"/>
        <symbol id="Lbar" table="L" row="200"/>
        <symbol id="Lbarbold" table="L" row="210"/>
        <symbol id="Lbarbolditalic" table="L" row="230"/>
        <symbol id="Lbaritalic" table="L" row="220"/>
        <symbol id="Lhat" table="L" row="160"/>
        <symbol id="Lhatbold" table="L" row="170"/>
        <symbol id="Lhatbolditalic" table="L" row="190"/>
        <symbol id="Lhatitalic" table="L" row="180"/>
        <symbol id="Lvec" table="L" row="290"/>
        <symbol id="Lvecbold" table="L" row="300"/>
        <symbol id="Lvecbolditalic" table="L" row="320"/>
        <symbol id="Lvecitalic" table="L" row="310"/>
        <symbol id="Marrow" table="M" row="250"/>
        <symbol id="Marrowbold" table="M" row="260"/>
        <symbol id="Marrowbolditalic" table="M" row="280"/>
        <symbol id="Marrowitalic" table="M" row="270"/>
        <symbol id="Mbar" table="M" row="200"/>
        <symbol id="Mbarbold" table="M" row="210"/>
        <symbol id="Mbarbolditalic" table="M" row="230"/>
        <symbol id="Mbaritalic" table="M" row="220"/>
        <symbol id="Mhat" table="M" row="160"/>
        <symbol id="Mhatbold" table="M" row="170"/>
        <symbol id="Mhatbolditalic" table="M" row="190"/>
        <symbol id="Mhatitalic" table="M" row="180"/>
        <symbol id="Mu"/>
        <symbol id="Mu2"/>
        <symbol id="Mubar"/>
        <symbol id="Mudbldot"/>
        <symbol id="Mudot"/>
        <symbol id="Muhat"/>
        <symbol id="Muvec"/>
        <symbol id="Mvec" table="M" row="290"/>
        <symbol id="Mvecbold" table="M" row="300"/>
        <symbol id="Mvecbolditalic" table="M" row="320"/>
        <symbol id="Mvecitalic" table="M" row="310"/>
        <symbol id="NEarrow"/>
        <symbol id="NWarrow"/>
        <symbol id="Narrow" table="N" row="250"/>
        <symbol id="Narrowbold" table="N" row="260"/>
        <symbol id="Narrowbolditalic" table="N" row="280"/>
        <symbol id="Narrowitalic" table="N" row="270"/>
        <symbol id="Nbar" table="N" row="200"/>
        <symbol id="Nbarbold" table="N" row="210"/>
        <symbol id="Nbarbolditalic" table="N" row="230"/>
        <symbol id="Nbaritalic" table="N" row="220"/>
        <symbol id="Nhat" table="N" row="160"/>
        <symbol id="Nhatbold" table="N" row="170"/>
        <symbol id="Nhatitalic" table="N" row="180"/>
        <symbol id="Ntilde" table="N" row="150"/>
        <symbol id="Nu"/>
        <symbol id="Nu2"/>
        <symbol id="Nubar"/>
        <symbol id="Nudbldot"/>
        <symbol id="Nudot"/>
        <symbol id="Nuhat"/>
        <symbol id="Nuvec"/>
        <symbol id="Nvec" table="N" row="290"/>
        <symbol id="Nvecbold" table="N" row="300"/>
        <symbol id="Nvecbolditalic" table="N" row="320"/>
        <symbol id="Nvecitalic" table="N" row="310"/>
        <symbol id="OElig"/>
        <symbol id="Oacute" table="O" row="100"/>
        <symbol id="Oarrow" table="O" row="250"/>
        <symbol id="Oarrowbold" table="O" row="260"/>
        <symbol id="Oarrowbolditalic" table="O" row="280"/>
        <symbol id="Oarrowitalic" table="O" row="270"/>
        <symbol id="Obar" table="O" row="200"/>
        <symbol id="Obarbold" table="O" row="210"/>
        <symbol id="Obarbolditalic" table="O" row="230"/>
        <symbol id="Obaritalic" table="O" row="220"/>
        <symbol id="Ocirc"/>
        <symbol id="Ograve" table="O" row="110"/>
        <symbol id="Ohat" table="O" row="160"/>
        <symbol id="Ohatbold" table="O" row="170"/>
        <symbol id="Ohatbolditalic" table="O" row="190"/>
        <symbol id="Ohatitalic" table="O" row="180"/>
        <symbol id="Omega"/>
        <symbol id="Omega2"/>
        <symbol id="Omegabar"/>
        <symbol id="Omegadbldot"/>
        <symbol id="Omegadot"/>
        <symbol id="Omegahat"/>
        <symbol id="Omegavec"/>
        <symbol id="Omicron"/>
        <symbol id="Omicron2"/>
        <symbol id="Omicronbar"/>
        <symbol id="Omicrondbldot"/>
        <symbol id="Omicrondot"/>
        <symbol id="Omicronhat"/>
        <symbol id="Omicronvec"/>
        <symbol id="Oslash"/>
        <symbol id="Otilde" table="O" row="150"/>
        <symbol id="Ouml" table="O" row="120"/>
        <symbol id="Ovec" table="O" row="290"/>
        <symbol id="Ovecbold" table="O" row="300"/>
        <symbol id="Ovecbolditalic" table="O" row="320"/>
        <symbol id="Ovecitalic" table="O" row="310"/>
        <symbol id="PQvecitalic"/>
        <symbol id="PRvecitalic"/>
        <symbol id="Parrow" table="P" row="250"/>
        <symbol id="Parrowbold" table="P" row="260"/>
        <symbol id="Parrowbolditalic" table="P" row="280"/>
        <symbol id="Parrowitalic" table="P" row="270"/>
        <symbol id="Pbar" table="P" row="200"/>
        <symbol id="Pbarbold" table="P" row="210"/>
        <symbol id="Pbarbolditalic" table="P" row="230"/>
        <symbol id="Pbaritalic" table="P" row="220"/>
        <symbol id="Phat" table="P" row="160"/>
        <symbol id="Phatbold" table="P" row="170"/>
        <symbol id="Phatbolditalic" table="P" row="190"/>
        <symbol id="Phatitalic" table="P" row="180"/>
        <symbol id="Phi"/>
        <symbol id="Phi2"/>
        <symbol id="Phibar"/>
        <symbol id="Phidbldot"/>
        <symbol id="Phidot"/>
        <symbol id="Phihat"/>
        <symbol id="Phivec"/>
        <symbol id="Pi"/>
        <symbol id="Pi2"/>
        <symbol id="Pibar"/>
        <symbol id="Pidbldot"/>
        <symbol id="Pidot"/>
        <symbol id="Pihat"/>
        <symbol id="Pivec"/>
        <symbol id="Psi"/>
        <symbol id="Psi2"/>
        <symbol id="Psibar"/>
        <symbol id="Psidbldot"/>
        <symbol id="Psidot"/>
        <symbol id="Psihat"/>
        <symbol id="Psivec"/>
        <symbol id="Pvec" table="P" row="290"/>
        <symbol id="Pvecbold" table="P" row="300"/>
        <symbol id="Pvecbolditalic" table="P" row="320"/>
        <symbol id="Pvecitalic" table="P" row="310"/>
        <symbol id="Qarrow" table="Q" row="250"/>
        <symbol id="Qarrowbold" table="Q" row="260"/>
        <symbol id="Qarrowbolditalic" table="Q" row="280"/>
        <symbol id="Qarrowitalic" table="Q" row="270"/>
        <symbol id="Qbar" table="Q" row="200"/>
        <symbol id="Qbarbold" table="Q" row="210"/>
        <symbol id="Qbarbolditalic" table="Q" row="230"/>
        <symbol id="Qbaritalic" table="Q" row="220"/>
        <symbol id="Qhat" table="Q" row="160"/>
        <symbol id="Qhatbold" table="Q" row="170"/>
        <symbol id="Qhatbolditalic" table="Q" row="190"/>
        <symbol id="Qhatitalic" table="Q" row="180"/>
        <symbol id="Qvec" table="Q" row="290"/>
        <symbol id="Qvecbold" table="Q" row="300"/>
        <symbol id="Qvecbolditalic" table="Q" row="320"/>
        <symbol id="Qvecitalic" table="Q" row="310"/>
        <symbol id="Rarrow" table="R" row="250"/>
        <symbol id="Rarrowbold" table="R" row="260"/>
        <symbol id="Rarrowbolditalic" table="R" row="280"/>
        <symbol id="Rarrowitalic" table="R" row="270"/>
        <symbol id="Rbar" table="R" row="200"/>
        <symbol id="Rbaritalic" table="R" row="220"/>
        <symbol id="Reals"/>
        <symbol id="Reals2"/>
        <symbol id="Rhat" table="R" row="160"/>
        <symbol id="Rhatbold" table="R" row="170"/>
        <symbol id="Rhatbolditalic" table="R" row="190"/>
        <symbol id="Rhatitalic" table="R" row="180"/>
        <symbol id="Rho"/>
        <symbol id="Rho2"/>
        <symbol id="Rhobar"/>
        <symbol id="Rhodbldot"/>
        <symbol id="Rhodot"/>
        <symbol id="Rhohat"/>
        <symbol id="Rhovec"/>
        <symbol id="Rvec" table="R" row="290"/>
        <symbol id="Rvecbold" table="R" row="300"/>
        <symbol id="Rvecbolditalic" table="R" row="320"/>
        <symbol id="Rvecitalic" table="R" row="310"/>
        <symbol id="SEarrow"/>
        <symbol id="SWarrow"/>
        <symbol id="Sarrow" table="S" row="250"/>
        <symbol id="Sarrowbold" table="S" row="260"/>
        <symbol id="Sarrowbolditalic" table="S" row="280"/>
        <symbol id="Sarrowitalic" table="S" row="270"/>
        <symbol id="Sbar" table="S" row="200"/>
        <symbol id="Sbarbold" table="S" row="210"/>
        <symbol id="Sbarbolditalic" table="S" row="230"/>
        <symbol id="Sbaritalic" table="S" row="220"/>
        <symbol id="Scaron"/>
        <symbol id="Shat" table="S" row="160"/>
        <symbol id="Shatbold" table="S" row="170"/>
        <symbol id="Shatbolditalic" table="S" row="190"/>
        <symbol id="Shatitalic" table="S" row="180"/>
        <symbol id="Sigma"/>
        <symbol id="Sigma2"/>
        <symbol id="Sigmabar"/>
        <symbol id="Sigmadbldot"/>
        <symbol id="Sigmadot"/>
        <symbol id="Sigmahat"/>
        <symbol id="Sigmavec"/>
        <symbol id="Svecbold" table="S" row="300"/>
        <symbol id="Svecbolditalic" table="S" row="320"/>
        <symbol id="Svecitalic" table="S" row="310"/>
        <symbol id="THORN"/>
        <symbol id="Tarrow" table="T" row="250"/>
        <symbol id="Tarrowbold" table="T" row="260"/>
        <symbol id="Tarrowbolditalic" table="T" row="280"/>
        <symbol id="Tarrowitalic" table="T" row="270"/>
        <symbol id="Tau"/>
        <symbol id="Tau2"/>
        <symbol id="Taubar"/>
        <symbol id="Taudbldot"/>
        <symbol id="Taudot"/>
        <symbol id="Tauhat"/>
        <symbol id="Tauvec"/>
        <symbol id="Tbar" table="T" row="200"/>
        <symbol id="Tbarbold" table="T" row="210"/>
        <symbol id="Tbarbolditalic" table="T" row="230"/>
        <symbol id="Tbaritalic" table="T" row="220"/>
        <symbol id="That" table="T" row="160"/>
        <symbol id="Thatbold" table="T" row="170"/>
        <symbol id="Thatbolditalic" table="T" row="190"/>
        <symbol id="Thatitalic" table="T" row="180"/>
        <symbol id="Theta"/>
        <symbol id="Theta2"/>
        <symbol id="Thetabar"/>
        <symbol id="Thetadbldot"/>
        <symbol id="Thetadot"/>
        <symbol id="Thetahat"/>
        <symbol id="Thetavec"/>
        <symbol id="Tvec" table="T" row="290"/>
        <symbol id="Tvecbold" table="T" row="300"/>
        <symbol id="Tvecbolditalic" table="T" row="320"/>
        <symbol id="Tvecitalic" table="T" row="310"/>
        <symbol id="Uacute" table="U" row="100"/>
        <symbol id="Uarrow" table="U" row="250"/>
        <symbol id="Uarrowbold" table="U" row="260"/>
        <symbol id="Uarrowbolditalic" table="U" row="280"/>
        <symbol id="Uarrowitalic" table="U" row="270"/>
        <symbol id="Ubar" table="U" row="200"/>
        <symbol id="Ubarbold" table="U" row="210"/>
        <symbol id="Ubarbolditalic" table="U" row="230"/>
        <symbol id="Ubaritalic" table="U" row="220"/>
        <symbol id="Ucirc"/>
        <symbol id="Ugrave" table="U" row="110"/>
        <symbol id="Uhat" table="U" row="160"/>
        <symbol id="Uhatbold" table="U" row="170"/>
        <symbol id="Uhatbolditalic" table="U" row="190"/>
        <symbol id="Uhatitalic" table="U" row="180"/>
        <symbol id="Upsilon"/>
        <symbol id="Upsilon2"/>
        <symbol id="Upsilonbar"/>
        <symbol id="Upsilondbldot"/>
        <symbol id="Upsilondot"/>
        <symbol id="Upsilonhat"/>
        <symbol id="Upsilonvec"/>
        <symbol id="Uuml" table="U" row="120"/>
        <symbol id="Uvec" table="U" row="290"/>
        <symbol id="Uvecbold" table="U" row="300"/>
        <symbol id="Uvecbolditalic" table="U" row="320"/>
        <symbol id="Uvecitalic" table="U" row="310"/>
        <symbol id="Varrow" table="V" row="250"/>
        <symbol id="Varrowbold" table="V" row="260"/>
        <symbol id="Varrowbolditalic" table="V" row="280"/>
        <symbol id="Varrowitalic" table="V" row="270"/>
        <symbol id="Vbar" table="V" row="200"/>
        <symbol id="Vbarbold" table="V" row="210"/>
        <symbol id="Vbarbolditalic" table="V" row="230"/>
        <symbol id="Vbaritalic" table="V" row="220"/>
        <symbol id="Vdot" table="V" row="130"/>
        <symbol id="Vhat" table="V" row="160"/>
        <symbol id="Vhatbold" table="V" row="170"/>
        <symbol id="Vhatbolditalic" table="V" row="190"/>
        <symbol id="Vhatitalic" table="V" row="180"/>
        <symbol id="Vvec" table="V" row="290"/>
        <symbol id="Vvecbold" table="V" row="300"/>
        <symbol id="Vvecbolditalic" table="V" row="320"/>
        <symbol id="Vvecitalic" table="V" row="310"/>
        <symbol id="Warrow" table="W" row="250"/>
        <symbol id="Warrowbold" table="W" row="260"/>
        <symbol id="Warrowbolditalic" table="W" row="280"/>
        <symbol id="Wbar" table="W" row="200"/>
        <symbol id="Wbarbold" table="W" row="210"/>
        <symbol id="Wbarbolditalic" table="W" row="230"/>
        <symbol id="Wbaritalic" table="W" row="220"/>
        <symbol id="What" table="W" row="160"/>
        <symbol id="Whatbold" table="W" row="170"/>
        <symbol id="Whatbolditalic" table="W" row="190"/>
        <symbol id="Whatitalic" table="W" row="180"/>
        <symbol id="Wvec" table="W" row="290"/>
        <symbol id="Wvecbold" table="W" row="300"/>
        <symbol id="Wvecbolditalic" table="W" row="320"/>
        <symbol id="Wvecitalic" table="W" row="310"/>
        <symbol id="Xarrow" table="X" row="250"/>
        <symbol id="Xarrowbold" table="X" row="260"/>
        <symbol id="Xarrowbolditalic" table="X" row="280"/>
        <symbol id="Xarrowitalic" table="X" row="270"/>
        <symbol id="Xbar" table="X" row="200"/>
        <symbol id="Xbarbold" table="X" row="210"/>
        <symbol id="Xbarbolditalic" table="X" row="230"/>
        <symbol id="Xbaritalic" table="X" row="220"/>
        <symbol id="Xhat" table="X" row="160"/>
        <symbol id="Xhatbold" table="X" row="170"/>
        <symbol id="Xhatbolditalic" table="X" row="190"/>
        <symbol id="Xhatitalic" table="X" row="180"/>
        <symbol id="Xi"/>
        <symbol id="Xi2"/>
        <symbol id="Xibar"/>
        <symbol id="Xidbldot"/>
        <symbol id="Xidot"/>
        <symbol id="Xihat"/>
        <symbol id="Xivec"/>
        <symbol id="Xtilde" table="X" row="150"/>
        <symbol id="Xvecbold" table="X" row="300"/>
        <symbol id="Xvecbolditalic" table="X" row="320"/>
        <symbol id="Xvecitalic" table="X" row="310"/>
        <symbol id="Yacute" table="Y" row="100"/>
        <symbol id="Yarrow" table="Y" row="250"/>
        <symbol id="Yarrowbold" table="Y" row="260"/>
        <symbol id="Yarrowbolditalic" table="Y" row="280"/>
        <symbol id="Yarrowitalic" table="Y" row="270"/>
        <symbol id="Ybar" table="Y" row="200"/>
        <symbol id="Ybarbold" table="Y" row="210"/>
        <symbol id="Ybarbolditalic" table="Y" row="230"/>
        <symbol id="Ybaritalic" table="Y" row="220"/>
        <symbol id="Yhat" table="Y" row="160"/>
        <symbol id="Yhatbold" table="Y" row="170"/>
        <symbol id="Yhatbolditalic" table="Y" row="190"/>
        <symbol id="Yhatitalic" table="Y" row="180"/>
        <symbol id="Yuml" table="Y" row="120"/>
        <symbol id="Yvec" table="Y" row="290"/>
        <symbol id="Yvecbold" table="Y" row="300"/>
        <symbol id="Yvecbolditalic" table="Y" row="320"/>
        <symbol id="Yvecitalic" table="Y" row="310"/>
        <symbol id="Zarrow" table="Z" row="250"/>
        <symbol id="Zarrowbold" table="Z" row="260"/>
        <symbol id="Zarrowbolditalic" table="Z" row="280"/>
        <symbol id="Zbar" table="Z" row="200"/>
        <symbol id="Zbarbold" table="Z" row="210"/>
        <symbol id="Zbarbolditalic" table="Z" row="230"/>
        <symbol id="Zbaritalic" table="Z" row="220"/>
        <symbol id="Zeta"/>
        <symbol id="Zeta2"/>
        <symbol id="Zetabar"/>
        <symbol id="Zetadbldot"/>
        <symbol id="Zetadot"/>
        <symbol id="Zetahat"/>
        <symbol id="Zetavec"/>
        <symbol id="Zhat" table="Z" row="160"/>
        <symbol id="Zhatbold" table="Z" row="170"/>
        <symbol id="Zhatbolditalic" table="Z" row="190"/>
        <symbol id="Zhatitalic" table="Z" row="180"/>
        <symbol id="Zvec" table="Z" row="290"/>
        <symbol id="Zvecbold" table="Z" row="300"/>
        <symbol id="Zvecitalic" table="Z" row="310"/>
        <symbol id="a-umlaut" table="a" row="120"/>
        <symbol id="aacute" table="a" row="100"/>
        <symbol id="aarrow" table="a" row="250"/>
        <symbol id="aarrowbold" table="a" row="260"/>
        <symbol id="aarrowbolditalic" table="a" row="280"/>
        <symbol id="aarrowitalic" table="a" row="270"/>
        <symbol id="abar" table="a" row="200"/>
        <symbol id="abarbold" table="a" row="210"/>
        <symbol id="abarbolditalic" table="a" row="230"/>
        <symbol id="abaritalic" table="a" row="220"/>
        <symbol id="abline"/>
        <symbol id="acirc"/>
        <symbol id="acute"/>
        <symbol id="aelig"/>
        <symbol id="agrave" table="a" row="110"/>
        <symbol id="ahat" table="a" row="160"/>
        <symbol id="ahatbold" table="a" row="170"/>
        <symbol id="ahatbolditalic" table="a" row="190"/>
        <symbol id="ahatitalic" table="a" row="180"/>
        <symbol id="aleph"/>
        <symbol id="almostequal"/>
        <symbol id="almostequal_equal"/>
        <symbol id="alpha"/>
        <symbol id="alpha2"/>
        <symbol id="alphaarrowbold"/>
        <symbol id="alphabar"/>
        <symbol id="alphabold"/>
        <symbol id="alphadbldot"/>
        <symbol id="alphadot"/>
        <symbol id="alphahat"/>
        <symbol id="alphaparticle"/>
        <symbol id="alphavec"/>
        <symbol id="ampersand"/>
        <symbol id="and"/>
        <symbol id="angle"/>
        <symbol id="angstrom"/>
        <symbol id="ankh"/>
        <symbol id="apostrophe"/>
        <symbol id="approx"/>
        <symbol id="approximate"/>
        <symbol id="arc"/>
        <symbol id="arc_btm"/>
        <symbol id="arc_ne"/>
        <symbol id="arc_nw"/>
        <symbol id="arc_se"/>
        <symbol id="arc_sw"/>
        <symbol id="arc_top"/>
        <symbol id="aring"/>
        <symbol id="aromaticbond"/>
        <symbol id="aromaticbondshort"/>
        <symbol id="arrow_circ_anti"/>
        <symbol id="arrow_circ_clock"/>
        <symbol id="arrow_dbl_do"/>
        <symbol id="arrow_dbl_ne"/>
        <symbol id="arrow_dbl_nw"/>
        <symbol id="arrow_dbl_se"/>
        <symbol id="arrow_dbl_sw"/>
        <symbol id="arrow_dbl_ver"/>
        <symbol id="arrow_do"/>
        <symbol id="arrow_do_do"/>
        <symbol id="arrow_do_lf"/>
        <symbol id="arrow_do_rt"/>
        <symbol id="arrow_lf_lf"/>
        <symbol id="arrow_lf_rt"/>
        <symbol id="arrow_rt_rt"/>
        <symbol id="arrow_semi_anti"/>
        <symbol id="arrow_semi_clock"/>
        <symbol id="arrow_trp_lf"/>
        <symbol id="arrow_trp_rt"/>
        <symbol id="arrow_up_up"/>
        <symbol id="arrowbold"/>
        <symbol id="arrowboldleft"/>
        <symbol id="assertion"/>
        <symbol id="asterisk"/>
        <symbol id="asterism"/>
        <symbol id="asymptotic"/>
        <symbol id="at"/>
        <symbol id="atilde" table="a" row="150"/>
        <symbol id="auml" table="a" row="120"/>
        <symbol id="avec" table="a" row="290"/>
        <symbol id="avecbold" table="a" row="300"/>
        <symbol id="avecbolditalic" table="a" row="320"/>
        <symbol id="avecitalic" table="a" row="310"/>
        <symbol id="backslash"/>
        <symbol id="barrowbold" table="b" row="260"/>
        <symbol id="barrowbolditalic" table="b" row="280"/>
        <symbol id="barrowitalic" table="b" row="270"/>
        <symbol id="basis"/>
        <symbol id="basisC"/>
        <symbol id="basisD"/>
        <symbol id="basissm"/>
        <symbol id="bbH"/>
        <symbol id="bbN"/>
        <symbol id="bbP"/>
        <symbol id="bbQ"/>
        <symbol id="bbQprime"/>
        <symbol id="bbR"/>
        <symbol id="bbW"/>
        <symbol id="bbZ"/>
        <symbol id="bbar" table="b" row="200"/>
        <symbol id="bbarbold" table="b" row="210"/>
        <symbol id="bbarbolditalic" table="b" row="230"/>
        <symbol id="bbaritalic" table="b" row="220"/>
        <symbol id="bdagger"/>
        <symbol id="bdbldot" table="b" row="140"/>
        <symbol id="bddagger"/>
        <symbol id="bdot" table="b" row="130"/>
        <symbol id="because"/>
        <symbol id="bet"/>
        <symbol id="beta"/>
        <symbol id="beta2"/>
        <symbol id="betabar"/>
        <symbol id="betadbldot"/>
        <symbol id="betadot"/>
        <symbol id="betahat"/>
        <symbol id="betaminus"/>
        <symbol id="betaplus"/>
        <symbol id="betavec"/>
        <symbol id="bhat" table="b" row="160"/>
        <symbol id="bhatbold" table="b" row="170"/>
        <symbol id="bhatbolditalic" table="b" row="190"/>
        <symbol id="bhatitalic" table="b" row="180"/>
        <symbol id="bicond"/>
        <symbol id="bicond_acc"/>
        <symbol id="bigbackslash"/>
        <symbol id="bigdiv"/>
        <symbol id="bigline"/>
        <symbol id="bigslash"/>
        <symbol id="blackdot"/>
        <symbol id="bottomintegral"/>
        <symbol id="bowtie_op"/>
        <symbol id="bra"/>
        <symbol id="brokenbar"/>
        <symbol id="bullet"/>
        <symbol id="bullet_op"/>
        <symbol id="bullseye"/>
        <symbol id="bvec" table="b" row="290"/>
        <symbol id="bvecbold" table="b" row="300"/>
        <symbol id="bvecbolditalic" table="b" row="320"/>
        <symbol id="bvecitalic" table="b" row="310"/>
        <symbol id="cBbar"/>
        <symbol id="caduceus"/>
        <symbol id="calB" table="B" row="335"/>
        <symbol id="calBsm"/>
        <symbol id="calC" table="C" row="335"/>
        <symbol id="calCsm"/>
        <symbol id="calD" table="D" row="335"/>
        <symbol id="calDsm"/>
        <symbol id="calG" table="G" row="335"/>
        <symbol id="calG_tilde"/>
        <symbol id="calGsm"/>
        <symbol id="calGsm_tilde"/>
        <symbol id="calH" table="H" row="335"/>
        <symbol id="calM" table="M" row="335"/>
        <symbol id="calN" table="N" row="335"/>
        <symbol id="calO" table="O" row="335"/>
        <symbol id="calP" table="P" row="335"/>
        <symbol id="calQ" table="Q" row="335"/>
        <symbol id="calQsm"/>
        <symbol id="calR" table="R" row="335"/>
        <symbol id="calRsm"/>
        <symbol id="calS" table="S" row="335"/>
        <symbol id="calS_bold"/>
        <symbol id="calSsm"/>
        <symbol id="calSsm_bold"/>
        <symbol id="calT" table="T" row="335"/>
        <symbol id="calTsm"/>
        <symbol id="calV" table="V" row="335"/>
        <symbol id="calW" table="W" row="335"/>
        <symbol id="calWsm"/>
        <symbol id="caret"/>
        <symbol id="caret_sm"/>
        <symbol id="carrow" table="c" row="250"/>
        <symbol id="carrowbold" table="c" row="260"/>
        <symbol id="carrowbolditalic" table="c" row="280"/>
        <symbol id="carrowitalic" table="c" row="270"/>
        <symbol id="cbar" table="c" row="200"/>
        <symbol id="cbarbold" table="c" row="210"/>
        <symbol id="cbarbolditalic" table="c" row="230"/>
        <symbol id="cbaritalic" table="c" row="220"/>
        <symbol id="ccedil"/>
        <symbol id="cdots"/>
        <symbol id="cedil"/>
        <symbol id="cents"/>
        <symbol id="chat" table="c" row="160"/>
        <symbol id="chatbold" table="c" row="170"/>
        <symbol id="chatbolditalic" table="c" row="190"/>
        <symbol id="chatitalic" table="c" row="180"/>
        <symbol id="check"/>
        <symbol id="checklteq"/>
        <symbol id="chi"/>
        <symbol id="chi2"/>
        <symbol id="chibar"/>
        <symbol id="chidbldot"/>
        <symbol id="chidot"/>
        <symbol id="chihat"/>
        <symbol id="chivec"/>
        <symbol id="circle"/>
        <symbol id="circle1"/>
        <symbol id="circle2"/>
        <symbol id="circle3"/>
        <symbol id="circle4"/>
        <symbol id="circle5"/>
        <symbol id="circleA" table="A" row="340"/>
        <symbol id="circleAsm"/>
        <symbol id="circleB" table="B" row="340"/>
        <symbol id="circleBsm"/>
        <symbol id="circleC" table="C" row="340"/>
        <symbol id="circleCsm"/>
        <symbol id="circleD" table="D" row="340"/>
        <symbol id="circleE" table="E" row="340"/>
        <symbol id="circleF" table="F" row="340"/>
        <symbol id="circleG" table="G" row="340"/>
        <symbol id="circleH" table="H" row="340"/>
        <symbol id="circleI" table="I" row="340"/>
        <symbol id="circleJ" table="J" row="340"/>
        <symbol id="circleK" table="K" row="340"/>
        <symbol id="circleL" table="L" row="340"/>
        <symbol id="circleM" table="M" row="340"/>
        <symbol id="circleN" table="N" row="340"/>
        <symbol id="circleO" table="O" row="340"/>
        <symbol id="circleP" table="P" row="340"/>
        <symbol id="circleR" table="R" row="340"/>
        <symbol id="circleS" table="S" row="340"/>
        <symbol id="circleT" table="T" row="340"/>
        <symbol id="circleU" table="U" row="340"/>
        <symbol id="circleV" table="V" row="340"/>
        <symbol id="circleW" table="W" row="340"/>
        <symbol id="circleX" table="X" row="340"/>
        <symbol id="circleY" table="Y" row="340"/>
        <symbol id="circleZ" table="Z" row="340"/>
        <symbol id="circle_black"/>
        <symbol id="circle_black_do"/>
        <symbol id="circle_black_lf"/>
        <symbol id="circle_black_rt"/>
        <symbol id="circle_black_up"/>
        <symbol id="circle_overlay"/>
        <symbol id="circle_white"/>
        <symbol id="circleasterisk"/>
        <symbol id="circledash"/>
        <symbol id="circledivide"/>
        <symbol id="circledot"/>
        <symbol id="circleequals"/>
        <symbol id="circleminus"/>
        <symbol id="circleplus"/>
        <symbol id="circlering"/>
        <symbol id="circletimes"/>
        <symbol id="circumflex"/>
        <symbol id="ckequal"/>
        <symbol id="ckgreater"/>
        <symbol id="ckgreaterequal"/>
        <symbol id="ckless"/>
        <symbol id="cklessequal"/>
        <symbol id="cleardot"/>
        <symbol id="clearline"/>
        <symbol id="clubs"/>
        <symbol id="coldrtarrow"/>
        <symbol id="colon"/>
        <symbol id="comma"/>
        <symbol id="complement"/>
        <symbol id="complex"/>
        <symbol id="compose"/>
        <symbol id="congruent"/>
        <symbol id="contains"/>
        <symbol id="contourintegral"/>
        <symbol id="copy"/>
        <symbol id="copyright"/>
        <symbol id="correspondence"/>
        <symbol id="corresponds"/>
        <symbol id="cross"/>
        <symbol id="cross_grey3"/>
        <symbol id="cubic_root"/>
        <symbol id="currency"/>
        <symbol id="curvedleftarrow"/>
        <symbol id="curvedrtarrow"/>
        <symbol id="curvedupdownarrow"/>
        <symbol id="cvec" table="c" row="290"/>
        <symbol id="cvecbold" table="c" row="300"/>
        <symbol id="cvecbolditalic" table="c" row="320"/>
        <symbol id="cvecitalic" table="c" row="310"/>
        <symbol id="dagger"/>
        <symbol id="dalet"/>
        <symbol id="darrow" table="d" row="250"/>
        <symbol id="darrowbold" table="d" row="260"/>
        <symbol id="darrowbolditalic" table="d" row="280"/>
        <symbol id="darrowitalic" table="d" row="270"/>
        <symbol id="dbar" table="d" row="200"/>
        <symbol id="dbarbold" table="d" row="210"/>
        <symbol id="dbarbolditalic" table="d" row="230"/>
        <symbol id="dbaritalic" table="d" row="220"/>
        <symbol id="dbl_vertical"/>
        <symbol id="decrtarrow"/>
        <symbol id="degC"/>
        <symbol id="degF"/>
        <symbol id="degree"/>
        <symbol id="delta"/>
        <symbol id="delta2"/>
        <symbol id="deltabar"/>
        <symbol id="deltadbldot"/>
        <symbol id="deltadot"/>
        <symbol id="deltahat"/>
        <symbol id="deltavec"/>
        <symbol id="dgarrowdnrt"/>
        <symbol id="dgarrowuprt"/>
        <symbol id="dhat" table="d" row="160"/>
        <symbol id="dhatbold" table="d" row="170"/>
        <symbol id="dhatbolditalic" table="d" row="190"/>
        <symbol id="dhatitalic" table="d" row="180"/>
        <symbol id="diaeresis"/>
        <symbol id="diamond_black"/>
        <symbol id="diamond_op"/>
        <symbol id="diamond_overlay"/>
        <symbol id="diamond_white"/>
        <symbol id="diamonds"/>
        <symbol id="diams"/>
        <symbol id="difference"/>
        <symbol id="divide"/>
        <symbol id="divslash"/>
        <symbol id="dollar"/>
        <symbol id="doteq"/>
        <symbol id="double"/>
        <symbol id="doubleC"/>
        <symbol id="doubleH"/>
        <symbol id="doubleN"/>
        <symbol id="doubleP"/>
        <symbol id="doubleQ"/>
        <symbol id="doubleR"/>
        <symbol id="doubleZ"/>
        <symbol id="doublebond"/>
        <symbol id="doubleint_r"/>
        <symbol id="doubleintegral"/>
        <symbol id="doublelineint"/>
        <symbol id="doubleprime"/>
        <symbol id="doublequote"/>
        <symbol id="downarrow"/>
        <symbol id="downdoublearrow"/>
        <symbol id="downimplies"/>
        <symbol id="downleftarrow"/>
        <symbol id="downrightarrow"/>
        <symbol id="downtack"/>
        <symbol id="dvec" table="d" row="290"/>
        <symbol id="dvecbold" table="d" row="300"/>
        <symbol id="dvecbolditalic" table="d" row="320"/>
        <symbol id="dvecitalic" table="d" row="310"/>
        <symbol id="eacute" table="e" row="100"/>
        <symbol id="earrow" table="e" row="250"/>
        <symbol id="earrowbold" table="e" row="260"/>
        <symbol id="earrowbolditalic" table="e" row="280"/>
        <symbol id="earrowitalic" table="e" row="270"/>
        <symbol id="ebar" table="e" row="200"/>
        <symbol id="ebarbold" table="e" row="210"/>
        <symbol id="ebarbolditalic" table="e" row="230"/>
        <symbol id="ebaritalic" table="e" row="220"/>
        <symbol id="ecirc"/>
        <symbol id="eertarrow"/>
        <symbol id="egrave" table="e" row="110"/>
        <symbol id="ehat" table="e" row="160"/>
        <symbol id="ehatbold" table="e" row="170"/>
        <symbol id="ehatbolditalic" table="e" row="190"/>
        <symbol id="ehatitalic" table="e" row="180"/>
        <symbol id="electron"/>
        <symbol id="element"/>
        <symbol id="emf"/>
        <symbol id="empty"/>
        <symbol id="empty_set"/>
        <symbol id="end_proof"/>
        <symbol id="energyarrowlong"/>
        <symbol id="energyarrowshort"/>
        <symbol id="energyarrowsmall"/>
        <symbol id="epsilon"/>
        <symbol id="epsilon2"/>
        <symbol id="epsilon3"/>
        <symbol id="epsilon_acc"/>
        <symbol id="epsilonbar"/>
        <symbol id="epsilondbldot"/>
        <symbol id="epsilondot"/>
        <symbol id="epsilonhat"/>
        <symbol id="epsilontilde"/>
        <symbol id="epsilonvec"/>
        <symbol id="eqq"/>
        <symbol id="equal_all"/>
        <symbol id="equal_geom"/>
        <symbol id="equal_greater"/>
        <symbol id="equal_less"/>
        <symbol id="equal_parallel"/>
        <symbol id="equal_precedes"/>
        <symbol id="equal_succeeds"/>
        <symbol id="equals"/>
        <symbol id="equiangular"/>
        <symbol id="equilarrow"/>
        <symbol id="equiv_geom"/>
        <symbol id="equiv_strict"/>
        <symbol id="equiv_to"/>
        <symbol id="equivalent"/>
        <symbol id="estimated"/>
        <symbol id="estimates"/>
        <symbol id="eta"/>
        <symbol id="eta2"/>
        <symbol id="etabar"/>
        <symbol id="etadbldot"/>
        <symbol id="etadot"/>
        <symbol id="etahat"/>
        <symbol id="etavec"/>
        <symbol id="eth"/>
        <symbol id="euler"/>
        <symbol id="euml" table="e" row="120"/>
        <symbol id="euro"/>
        <symbol id="evec" table="e" row="290"/>
        <symbol id="evecbold" table="e" row="300"/>
        <symbol id="evecbolditalic" table="e" row="320"/>
        <symbol id="evecitalic" table="e" row="310"/>
        <symbol id="exclamation"/>
        <symbol id="exists"/>
        <symbol id="farrow" table="f" row="250"/>
        <symbol id="farrowbold" table="f" row="260"/>
        <symbol id="farrowbolditalic" table="f" row="280"/>
        <symbol id="farrowitalic" table="f" row="270"/>
        <symbol id="fbar" table="f" row="200"/>
        <symbol id="fbarbold" table="f" row="210"/>
        <symbol id="fbarbolditalic" table="f" row="230"/>
        <symbol id="fbaritalic" table="f" row="220"/>
        <symbol id="fdash"/>
        <symbol id="female"/>
        <symbol id="fhat" table="f" row="160"/>
        <symbol id="fhatbold" table="f" row="170"/>
        <symbol id="fhatbolditalic" table="f" row="190"/>
        <symbol id="fhatitalic" table="f" row="180"/>
        <symbol id="fnof"/>
        <symbol id="forall"/>
        <symbol id="forces"/>
        <symbol id="fprimex_acc"/>
        <symbol id="frac12"/>
        <symbol id="frac14"/>
        <symbol id="frac34"/>
        <symbol id="fracslash"/>
        <symbol id="frasl"/>
        <symbol id="fullstop"/>
        <symbol id="fvec" table="f" row="290"/>
        <symbol id="fvecbold" table="f" row="300"/>
        <symbol id="fvecbolditalic" table="f" row="320"/>
        <symbol id="fvecitalic" table="f" row="310"/>
        <symbol id="fx_acc"/>
        <symbol id="gamma"/>
        <symbol id="gamma2"/>
        <symbol id="gammabar"/>
        <symbol id="gammadbldot"/>
        <symbol id="gammadot"/>
        <symbol id="gammahat"/>
        <symbol id="gammavec"/>
        <symbol id="garrow" table="g" row="250"/>
        <symbol id="garrowbold" table="g" row="260"/>
        <symbol id="garrowbolditalic" table="g" row="280"/>
        <symbol id="garrowitalic" table="g" row="270"/>
        <symbol id="gbar" table="g" row="200"/>
        <symbol id="gbarbold" table="g" row="210"/>
        <symbol id="gbarbolditalic" table="g" row="230"/>
        <symbol id="gbaritalic" table="g" row="220"/>
        <symbol id="ghat" table="g" row="160"/>
        <symbol id="ghatbold" table="g" row="170"/>
        <symbol id="ghatbolditalic" table="g" row="190"/>
        <symbol id="ghatitalic" table="g" row="180"/>
        <symbol id="gimel"/>
        <symbol id="gprimex_acc"/>
        <symbol id="grave"/>
        <symbol id="greaterorequal"/>
        <symbol id="greaterthan"/>
        <symbol id="greaterthan_rq"/>
        <symbol id="greenOmega"/>
        <symbol id="greenmultiply"/>
        <symbol id="gvec" table="g" row="290"/>
        <symbol id="gvecbold" table="g" row="300"/>
        <symbol id="gvecbolditalic" table="g" row="320"/>
        <symbol id="gvecitalic" table="g" row="310"/>
        <symbol id="gx_acc"/>
        <symbol id="half"/>
        <symbol id="harp_do_lf"/>
        <symbol id="harp_lf_do"/>
        <symbol id="harp_lf_rt"/>
        <symbol id="harp_lf_up"/>
        <symbol id="harp_rt_do"/>
        <symbol id="harp_rt_up"/>
        <symbol id="harp_up_rt"/>
        <symbol id="harrow" table="h" row="250"/>
        <symbol id="harrowbold" table="h" row="260"/>
        <symbol id="harrowbolditalic" table="h" row="280"/>
        <symbol id="harrowitalic" table="h" row="270"/>
        <symbol id="hashmark"/>
        <symbol id="hbar" table="h" row="200"/>
        <symbol id="hbar2"/>
        <symbol id="hbarbold" table="h" row="210"/>
        <symbol id="hbarbolditalic" table="h" row="230"/>
        <symbol id="hbaritalic" table="h" row="220"/>
        <symbol id="hbarred"/>
        <symbol id="hearts"/>
        <symbol id="hellipsis"/>
        <symbol id="hellipsis_acc"/>
        <symbol id="hhat" table="h" row="160"/>
        <symbol id="hhatbold" table="h" row="170"/>
        <symbol id="hhatbolditalic" table="h" row="190"/>
        <symbol id="hhatitalic" table="h" row="180"/>
        <symbol id="hor_bar"/>
        <symbol id="hprimex_acc"/>
        <symbol id="hvec" table="h" row="290"/>
        <symbol id="hvecbold" table="h" row="300"/>
        <symbol id="hvecbolditalic" table="h" row="320"/>
        <symbol id="hvecitalic" table="h" row="310"/>
        <symbol id="hx_acc"/>
        <symbol id="hyphen"/>
        <symbol id="hyphen_nobr"/>
        <symbol id="iacute" table="i" row="100"/>
        <symbol id="iarrow" table="i" row="250"/>
        <symbol id="iarrowbold" table="i" row="260"/>
        <symbol id="iarrowbolditalic" table="i" row="280"/>
        <symbol id="iarrowitalic" table="i" row="270"/>
        <symbol id="ibar" table="i" row="200"/>
        <symbol id="ibaritalic" table="i" row="220"/>
        <symbol id="ibold" table="i" row="90"/>
        <symbol id="icirc"/>
        <symbol id="identical"/>
        <symbol id="igrave" table="i" row="110"/>
        <symbol id="ihat" table="i" row="160"/>
        <symbol id="ihatbold" table="i" row="170"/>
        <symbol id="ihatbolditalic" table="i" row="190"/>
        <symbol id="ihatbolditalicred"/>
        <symbol id="ihatboldred"/>
        <symbol id="ihatitalic" table="i" row="180"/>
        <symbol id="ihatitalicred"/>
        <symbol id="implies"/>
        <symbol id="increment"/>
        <symbol id="infin"/>
        <symbol id="infinity"/>
        <symbol id="infinity_acc"/>
        <symbol id="infinitysm"/>
        <symbol id="int"/>
        <symbol id="intbig"/>
        <symbol id="integers"/>
        <symbol id="integral"/>
        <symbol id="integral_anti_cont"/>
        <symbol id="integral_clock"/>
        <symbol id="integral_clock_cont"/>
        <symbol id="intercalate"/>
        <symbol id="interrobang"/>
        <symbol id="intersect"/>
        <symbol id="inv_exclamation"/>
        <symbol id="inv_ohm"/>
        <symbol id="inv_question"/>
        <symbol id="iota"/>
        <symbol id="iota2"/>
        <symbol id="iotabar"/>
        <symbol id="iotadbldot"/>
        <symbol id="iotadot"/>
        <symbol id="iotahat"/>
        <symbol id="iotavec"/>
        <symbol id="isin"/>
        <symbol id="italicf"/>
        <symbol id="iuml" table="i" row="120"/>
        <symbol id="ivec" table="i" row="290"/>
        <symbol id="ivecbold" table="i" row="300"/>
        <symbol id="ivecbolditalic" table="i" row="320"/>
        <symbol id="ivecitalic" table="i" row="310"/>
        <symbol id="jarrow" table="j" row="250"/>
        <symbol id="jarrowbold" table="j" row="260"/>
        <symbol id="jarrowbolditalic" table="j" row="280"/>
        <symbol id="jarrowitalic" table="j" row="270"/>
        <symbol id="jbar" table="j" row="200"/>
        <symbol id="jbarbold" table="j" row="210"/>
        <symbol id="jbarbolditalic" table="j" row="230"/>
        <symbol id="jbaritalic" table="j" row="220"/>
        <symbol id="jbold" table="j" row="90"/>
        <symbol id="jhat" table="j" row="160"/>
        <symbol id="jhatbold" table="j" row="170"/>
        <symbol id="jhatbolditalic" table="j" row="190"/>
        <symbol id="jhatbolditalicred"/>
        <symbol id="jhatboldred"/>
        <symbol id="jhatitalic" table="j" row="180"/>
        <symbol id="jhatitalicred"/>
        <symbol id="jvec" table="j" row="290"/>
        <symbol id="jvecbold" table="j" row="300"/>
        <symbol id="jvecbolditalic" table="j" row="320"/>
        <symbol id="jvecitalic" table="j" row="310"/>
        <symbol id="kappa"/>
        <symbol id="kappa2"/>
        <symbol id="kappabar"/>
        <symbol id="kappadbldot"/>
        <symbol id="kappadot"/>
        <symbol id="kappahat"/>
        <symbol id="kappavec"/>
        <symbol id="karrow" table="k" row="250"/>
        <symbol id="karrowbold" table="k" row="260"/>
        <symbol id="karrowbolditalic" table="k" row="280"/>
        <symbol id="karrowitalic" table="k" row="270"/>
        <symbol id="kbar" table="k" row="200"/>
        <symbol id="kbarbold" table="k" row="210"/>
        <symbol id="kbarbolditalic" table="k" row="230"/>
        <symbol id="kbaritalic" table="k" row="220"/>
        <symbol id="kbold" table="k" row="90"/>
        <symbol id="kelvin"/>
        <symbol id="ket"/>
        <symbol id="khat" table="k" row="160"/>
        <symbol id="khatbold" table="k" row="170"/>
        <symbol id="khatbolditalic" table="k" row="190"/>
        <symbol id="khatbolditalicred"/>
        <symbol id="khatboldred"/>
        <symbol id="khatitalic" table="k" row="180"/>
        <symbol id="khatitalicred"/>
        <symbol id="kvec" table="k" row="290"/>
        <symbol id="kvecbold" table="k" row="300"/>
        <symbol id="kvecbolditalic" table="k" row="320"/>
        <symbol id="kvecitalic" table="k" row="310"/>
        <symbol id="lambda"/>
        <symbol id="lambda2"/>
        <symbol id="lambdabar"/>
        <symbol id="lambdadbldot"/>
        <symbol id="lambdadot"/>
        <symbol id="lambdahat"/>
        <symbol id="lambdahatsmall"/>
        <symbol id="lambdavec"/>
        <symbol id="larrow" table="l" row="250"/>
        <symbol id="larrowbold" table="l" row="260"/>
        <symbol id="larrowbolditalic" table="l" row="280"/>
        <symbol id="larrowitalic" table="l" row="270"/>
        <symbol id="lbar" table="l" row="200"/>
        <symbol id="lbarbold" table="l" row="210"/>
        <symbol id="lbarbolditalic" table="l" row="230"/>
        <symbol id="lbaritalic" table="l" row="220"/>
        <symbol id="lceiling"/>
        <symbol id="ldot" table="l" row="130"/>
        <symbol id="ldquote"/>
        <symbol id="left_dbl_bar"/>
        <symbol id="leftarrow"/>
        <symbol id="leftbracket"/>
        <symbol id="leftcurly"/>
        <symbol id="leftdoublearrow"/>
        <symbol id="leftgrint"/>
        <symbol id="leftparens"/>
        <symbol id="leftrtarrow"/>
        <symbol id="lefttack"/>
        <symbol id="leftupvector"/>
        <symbol id="lellipsis"/>
        <symbol id="lessorequal"/>
        <symbol id="lessorequal_acc"/>
        <symbol id="lessthan"/>
        <symbol id="lessthan_lq"/>
        <symbol id="lewisdot"/>
        <symbol id="lfloor"/>
        <symbol id="lftarrowlong"/>
        <symbol id="lhat" table="l" row="160"/>
        <symbol id="lhatbold" table="l" row="170"/>
        <symbol id="lhatbolditalic" table="l" row="190"/>
        <symbol id="lhatitalic" table="l" row="180"/>
        <symbol id="lineint"/>
        <symbol id="lowast"/>
        <symbol id="lozenge"/>
        <symbol id="lsquote"/>
        <symbol id="lvec" table="l" row="290"/>
        <symbol id="lvecbold" table="l" row="300"/>
        <symbol id="lvecbolditalic" table="l" row="320"/>
        <symbol id="lvecitalic" table="l" row="310"/>
        <symbol id="macr"/>
        <symbol id="male"/>
        <symbol id="marrow" table="m" row="250"/>
        <symbol id="marrowbold" table="m" row="260"/>
        <symbol id="marrowbolditalic" table="m" row="280"/>
        <symbol id="marrowitalic" table="m" row="270"/>
        <symbol id="mbar" table="m" row="200"/>
        <symbol id="mbarbold" table="m" row="210"/>
        <symbol id="mbarbolditalic" table="m" row="230"/>
        <symbol id="mbaritalic" table="m" row="220"/>
        <symbol id="mdash"/>
        <symbol id="measuredangle"/>
        <symbol id="mellipsis"/>
        <symbol id="mhat" table="m" row="160"/>
        <symbol id="mhatbold" table="m" row="170"/>
        <symbol id="mhatbolditalic" table="m" row="190"/>
        <symbol id="mhatitalic" table="m" row="180"/>
        <symbol id="micro"/>
        <symbol id="micro2"/>
        <symbol id="middot"/>
        <symbol id="middot_acc"/>
        <symbol id="middot_op"/>
        <symbol id="minus"/>
        <symbol id="minus_acc"/>
        <symbol id="minusplus"/>
        <symbol id="minusplus_acc"/>
        <symbol id="ml"/>
        <symbol id="models"/>
        <symbol id="moon_fi_qrtr"/>
        <symbol id="moon_la_qrtr"/>
        <symbol id="mu"/>
        <symbol id="mu2"/>
        <symbol id="mu_acc"/>
        <symbol id="muarrowbold"/>
        <symbol id="mubar"/>
        <symbol id="muchgreaterthan"/>
        <symbol id="muchlessthan"/>
        <symbol id="mudbldot"/>
        <symbol id="mudot"/>
        <symbol id="muhat"/>
        <symbol id="multiply"/>
        <symbol id="music_flat"/>
        <symbol id="music_natural"/>
        <symbol id="music_sharp"/>
        <symbol id="mutilde"/>
        <symbol id="muvec"/>
        <symbol id="mvec" table="m" row="290"/>
        <symbol id="mvecbold" table="m" row="300"/>
        <symbol id="mvecbolditalic" table="m" row="320"/>
        <symbol id="mvecitalic" table="m" row="310"/>
        <symbol id="nabla"/>
        <symbol id="nabla_acc"/>
        <symbol id="nablaarrow"/>
        <symbol id="nand"/>
        <symbol id="narrow" table="n" row="250"/>
        <symbol id="narrowbold" table="n" row="260"/>
        <symbol id="narrowbolditalic" table="n" row="280"/>
        <symbol id="narrowitalic" table="n" row="270"/>
        <symbol id="nary_and"/>
        <symbol id="nary_coproduct"/>
        <symbol id="nary_intersect"/>
        <symbol id="nary_or"/>
        <symbol id="nary_product"/>
        <symbol id="nary_summation"/>
        <symbol id="nary_summation_acc"/>
        <symbol id="nary_union"/>
        <symbol id="naught"/>
        <symbol id="naught_hi"/>
        <symbol id="naught_lo"/>
        <symbol id="nbar" table="n" row="200"/>
        <symbol id="nbarbold" table="n" row="210"/>
        <symbol id="nbarbolditalic" table="n" row="230"/>
        <symbol id="nbaritalic" table="n" row="220"/>
        <symbol id="ndash"/>
        <symbol id="neg"/>
        <symbol id="neither_approx"/>
        <symbol id="neutron"/>
        <symbol id="nhat" table="n" row="160"/>
        <symbol id="nhatbold" table="n" row="170"/>
        <symbol id="nhatbolditalic" table="n" row="190"/>
        <symbol id="nhatitalic" table="n" row="180"/>
        <symbol id="no"/>
        <symbol id="nor"/>
        <symbol id="norm_subgr"/>
        <symbol id="norm_subgr_equal"/>
        <symbol id="not"/>
        <symbol id="not_almostequal"/>
        <symbol id="not_approx"/>
        <symbol id="not_asymptotic"/>
        <symbol id="not_contains"/>
        <symbol id="not_element"/>
        <symbol id="not_exists"/>
        <symbol id="not_forces"/>
        <symbol id="not_greater"/>
        <symbol id="not_identical"/>
        <symbol id="not_less"/>
        <symbol id="not_parallel"/>
        <symbol id="not_precedes"/>
        <symbol id="not_proves"/>
        <symbol id="not_subset"/>
        <symbol id="not_subset_neq"/>
        <symbol id="not_succeeds"/>
        <symbol id="not_superset"/>
        <symbol id="not_supersetneq"/>
        <symbol id="not_true"/>
        <symbol id="notcongruent"/>
        <symbol id="notdivides"/>
        <symbol id="note_16th_beam"/>
        <symbol id="note_8th"/>
        <symbol id="note_8th_beam"/>
        <symbol id="note_qrtr"/>
        <symbol id="notequal"/>
        <symbol id="notequiv"/>
        <symbol id="notgreater"/>
        <symbol id="notgreaterorequal"/>
        <symbol id="notin"/>
        <symbol id="notless"/>
        <symbol id="notlessorequal"/>
        <symbol id="notrelated"/>
        <symbol id="notsubset"/>
        <symbol id="ntilde" table="n" row="150"/>
        <symbol id="nu"/>
        <symbol id="nu2"/>
        <symbol id="nubar"/>
        <symbol id="nuclearparticles"/>
        <symbol id="nudbldot"/>
        <symbol id="nudot"/>
        <symbol id="nuhat"/>
        <symbol id="numero"/>
        <symbol id="nutilde"/>
        <symbol id="nuvec"/>
        <symbol id="nvec" table="n" row="290"/>
        <symbol id="nvecbold" table="n" row="300"/>
        <symbol id="nvecbolditalic" table="n" row="320"/>
        <symbol id="nvecitalic" table="n" row="310"/>
        <symbol id="o-umlaut" table="o" row="120"/>
        <symbol id="oacute" table="o" row="100"/>
        <symbol id="oaline"/>
        <symbol id="oarrow" table="o" row="250"/>
        <symbol id="oarrowbold" table="o" row="260"/>
        <symbol id="oarrowbolditalic" table="o" row="280"/>
        <symbol id="oarrowitalic" table="o" row="270"/>
        <symbol id="obar" table="o" row="200"/>
        <symbol id="obarbold" table="o" row="210"/>
        <symbol id="obarbolditalic" table="o" row="230"/>
        <symbol id="obaritalic" table="o" row="220"/>
        <symbol id="ocirc"/>
        <symbol id="odot" table="o" row="130"/>
        <symbol id="oelig"/>
        <symbol id="ograve" table="o" row="110"/>
        <symbol id="ohat" table="o" row="160"/>
        <symbol id="ohatbold" table="o" row="170"/>
        <symbol id="ohatbolditalic" table="o" row="190"/>
        <symbol id="ohatitalic" table="o" row="180"/>
        <symbol id="ohatred"/>
        <symbol id="ohm"/>
        <symbol id="omega"/>
        <symbol id="omega2"/>
        <symbol id="omegaarrowbold"/>
        <symbol id="omegabar"/>
        <symbol id="omegabold"/>
        <symbol id="omegadbldot"/>
        <symbol id="omegadot"/>
        <symbol id="omegahat"/>
        <symbol id="omegavec"/>
        <symbol id="omicron"/>
        <symbol id="omicron2"/>
        <symbol id="omicronbar"/>
        <symbol id="omicrondbldot"/>
        <symbol id="omicrondot"/>
        <symbol id="omicronhat"/>
        <symbol id="omicronvec"/>
        <symbol id="or"/>
        <symbol id="orb_d"/>
        <symbol id="orb_e"/>
        <symbol id="orb_none"/>
        <symbol id="orb_u"/>
        <symbol id="orb_ud"/>
        <symbol id="ordf"/>
        <symbol id="ordm"/>
        <symbol id="orthogonal"/>
        <symbol id="orthogonalsm"/>
        <symbol id="oslash"/>
        <symbol id="otilde" table="o" row="150"/>
        <symbol id="ouml" table="o" row="120"/>
        <symbol id="ovec" table="o" row="290"/>
        <symbol id="ovecbold" table="o" row="300"/>
        <symbol id="ovecbolditalic" table="o" row="320"/>
        <symbol id="ovecitalic" table="o" row="310"/>
        <symbol id="overline"/>
        <symbol id="overtie"/>
        <symbol id="parabdown"/>
        <symbol id="parabup"/>
        <symbol id="paragraph"/>
        <symbol id="parallel"/>
        <symbol id="parallel_black"/>
        <symbol id="parallel_s"/>
        <symbol id="parallel_white"/>
        <symbol id="parrow" table="p" row="250"/>
        <symbol id="parrowbold" table="p" row="260"/>
        <symbol id="parrowbolditalic" table="p" row="280"/>
        <symbol id="parrowitalic" table="p" row="270"/>
        <symbol id="partial"/>
        <symbol id="partialderivative_acc"/>
        <symbol id="pbar" table="p" row="200"/>
        <symbol id="pbarbold" table="p" row="210"/>
        <symbol id="pbarbolditalic" table="p" row="230"/>
        <symbol id="pbaritalic" table="p" row="220"/>
        <symbol id="percent"/>
        <symbol id="period"/>
        <symbol id="permille"/>
        <symbol id="phat" table="p" row="160"/>
        <symbol id="phatbold" table="p" row="170"/>
        <symbol id="phatbolditalic" table="p" row="190"/>
        <symbol id="phatitalic" table="p" row="180"/>
        <symbol id="phi"/>
        <symbol id="phi1"/>
        <symbol id="phi2"/>
        <symbol id="phi_acc"/>
        <symbol id="phibar"/>
        <symbol id="phibold"/>
        <symbol id="phidbldot"/>
        <symbol id="phidot"/>
        <symbol id="phihat"/>
        <symbol id="phihatbold"/>
        <symbol id="phioverline"/>
        <symbol id="phism"/>
        <symbol id="phivec"/>
        <symbol id="pi"/>
        <symbol id="pi2"/>
        <symbol id="pi_acc"/>
        <symbol id="pibar"/>
        <symbol id="pidbldot"/>
        <symbol id="pidot"/>
        <symbol id="pihat"/>
        <symbol id="pipe"/>
        <symbol id="pivec"/>
        <symbol id="planck"/>
        <symbol id="planckbar"/>
        <symbol id="plus"/>
        <symbol id="plusminus"/>
        <symbol id="plusminus_acc"/>
        <symbol id="positron"/>
        <symbol id="pound"/>
        <symbol id="precedes"/>
        <symbol id="precedes_equal"/>
        <symbol id="precedes_equiv"/>
        <symbol id="precedes_rel"/>
        <symbol id="prime"/>
        <symbol id="proportion"/>
        <symbol id="propto"/>
        <symbol id="proton"/>
        <symbol id="psi"/>
        <symbol id="psi2"/>
        <symbol id="psibar"/>
        <symbol id="psidbldot"/>
        <symbol id="psidot"/>
        <symbol id="psihat"/>
        <symbol id="psivec"/>
        <symbol id="ptilde" table="p" row="150"/>
        <symbol id="ptrtarrow"/>
        <symbol id="pvec" table="p" row="290"/>
        <symbol id="pvecbold" table="p" row="300"/>
        <symbol id="pvecbolditalic" table="p" row="320"/>
        <symbol id="pvecitalic" table="p" row="310"/>
        <symbol id="qarrow" table="q" row="250"/>
        <symbol id="qarrowbold" table="q" row="260"/>
        <symbol id="qarrowbolditalic" table="q" row="280"/>
        <symbol id="qarrowitalic" table="q" row="270"/>
        <symbol id="qbar" table="q" row="200"/>
        <symbol id="qbarbold" table="q" row="210"/>
        <symbol id="qbarbolditalic" table="q" row="230"/>
        <symbol id="qbaritalic" table="q" row="220"/>
        <symbol id="qhat" table="q" row="160"/>
        <symbol id="qhatbold" table="q" row="170"/>
        <symbol id="qhatbolditalic" table="q" row="190"/>
        <symbol id="qhatitalic" table="q" row="180"/>
        <symbol id="quad"/>
        <symbol id="question"/>
        <symbol id="qvec" table="q" row="290"/>
        <symbol id="qvecbold" table="q" row="300"/>
        <symbol id="qvecbolditalic" table="q" row="320"/>
        <symbol id="qvecitalic" table="q" row="310"/>
        <symbol id="rarrow" table="r" row="250"/>
        <symbol id="rarrowbold" table="r" row="260"/>
        <symbol id="rarrowbolditalic" table="r" row="280"/>
        <symbol id="rarrowitalic" table="r" row="270"/>
        <symbol id="ratio"/>
        <symbol id="rbar" table="r" row="200"/>
        <symbol id="rbarbold" table="r" row="210"/>
        <symbol id="rbarbolditalic" table="r" row="230"/>
        <symbol id="rbaritalic" table="r" row="220"/>
        <symbol id="rceiling"/>
        <symbol id="rdbldot" table="r" row="140"/>
        <symbol id="rdot" table="r" row="130"/>
        <symbol id="rdquote"/>
        <symbol id="redOmega"/>
        <symbol id="red_deg"/>
        <symbol id="red_pi"/>
        <symbol id="redcents"/>
        <symbol id="redmultiply"/>
        <symbol id="redplusminus"/>
        <symbol id="reference"/>
        <symbol id="reg"/>
        <symbol id="registered"/>
        <symbol id="rellipsis"/>
        <symbol id="repzero"/>
        <symbol id="rev_doubleprime"/>
        <symbol id="rev_prime"/>
        <symbol id="rev_tripleprime"/>
        <symbol id="revrxarrow"/>
        <symbol id="revrxarrow1"/>
        <symbol id="revrxarrow2"/>
        <symbol id="revrxarrowH20"/>
        <symbol id="revrxarrowhv"/>
        <symbol id="revrxarrowred"/>
        <symbol id="revrxnarrowk"/>
        <symbol id="revrxnarrowkco"/>
        <symbol id="revrxnarrowko2"/>
        <symbol id="revrxnk1"/>
        <symbol id="revrxnk2"/>
        <symbol id="revrxnkf"/>
        <symbol id="rfloor"/>
        <symbol id="rhat" table="r" row="160"/>
        <symbol id="rhatbold" table="r" row="170"/>
        <symbol id="rhatbolditalic" table="r" row="190"/>
        <symbol id="rhatitalic" table="r" row="180"/>
        <symbol id="rho"/>
        <symbol id="rho2"/>
        <symbol id="rho_acc"/>
        <symbol id="rhobar"/>
        <symbol id="rhodbldot"/>
        <symbol id="rhodot"/>
        <symbol id="rhohat"/>
        <symbol id="rhovec"/>
        <symbol id="right_dbl_bar"/>
        <symbol id="rightangle"/>
        <symbol id="rightarrow"/>
        <symbol id="rightarrow_acc"/>
        <symbol id="rightbracket"/>
        <symbol id="rightcurly"/>
        <symbol id="rightdoublearrow"/>
        <symbol id="rightdownvector"/>
        <symbol id="rightgrint"/>
        <symbol id="rightparens"/>
        <symbol id="righttack"/>
        <symbol id="ring_op"/>
        <symbol id="roman1"/>
        <symbol id="roman10"/>
        <symbol id="roman100"/>
        <symbol id="roman1000"/>
        <symbol id="roman1000_sm"/>
        <symbol id="roman100_sm"/>
        <symbol id="roman10_sm"/>
        <symbol id="roman11_sm"/>
        <symbol id="roman12_sm"/>
        <symbol id="roman1_sm"/>
        <symbol id="roman2"/>
        <symbol id="roman2_sm"/>
        <symbol id="roman3"/>
        <symbol id="roman3_sm"/>
        <symbol id="roman4"/>
        <symbol id="roman4_sm"/>
        <symbol id="roman5"/>
        <symbol id="roman50"/>
        <symbol id="roman500"/>
        <symbol id="roman500_sm"/>
        <symbol id="roman50_sm"/>
        <symbol id="roman5_sm"/>
        <symbol id="roman6"/>
        <symbol id="roman6_sm"/>
        <symbol id="roman7"/>
        <symbol id="roman7_sm"/>
        <symbol id="roman8"/>
        <symbol id="roman8_sm"/>
        <symbol id="roman9"/>
        <symbol id="roman9_sm"/>
        <symbol id="rsquote"/>
        <symbol id="rt_angle_arc"/>
        <symbol id="rtarrow"/>
        <symbol id="rtarrowAcid"/>
        <symbol id="rtarrowAcidic"/>
        <symbol id="rtarrowBacteria"/>
        <symbol id="rtarrowBase"/>
        <symbol id="rtarrowBasic"/>
        <symbol id="rtarrowClcat"/>
        <symbol id="rtarrowDelta"/>
        <symbol id="rtarrowE"/>
        <symbol id="rtarrowEc"/>
        <symbol id="rtarrowF"/>
        <symbol id="rtarrowH20"/>
        <symbol id="rtarrowHeat"/>
        <symbol id="rtarrowL"/>
        <symbol id="rtarrowNOcat"/>
        <symbol id="rtarrowPt"/>
        <symbol id="rtarrowac"/>
        <symbol id="rtarrowacidic"/>
        <symbol id="rtarrowalpha"/>
        <symbol id="rtarrowbeta"/>
        <symbol id="rtarrowcatalyst"/>
        <symbol id="rtarrowelec"/>
        <symbol id="rtarrowelecap"/>
        <symbol id="rtarrowelect"/>
        <symbol id="rtarrowheatpressure"/>
        <symbol id="rtarrowhex"/>
        <symbol id="rtarrowhotCuOs"/>
        <symbol id="rtarrowhv"/>
        <symbol id="rtarrowk"/>
        <symbol id="rtarrowk1"/>
        <symbol id="rtarrowk2"/>
        <symbol id="rtarrowk3"/>
        <symbol id="rtarrowk4"/>
        <symbol id="rtarrowlight"/>
        <symbol id="rtarrowlong"/>
        <symbol id="rtarrowox"/>
        <symbol id="rtarrowp"/>
        <symbol id="rtarrowpt825"/>
        <symbol id="rtarrowradeng"/>
        <symbol id="rtarrowsf"/>
        <symbol id="rtarrowyeast"/>
        <symbol id="rvec" table="r" row="290"/>
        <symbol id="rvecbold" table="r" row="300"/>
        <symbol id="rvecbolditalic" table="r" row="320"/>
        <symbol id="rvecitalic" table="r" row="310"/>
        <symbol id="sarrow" table="s" row="250"/>
        <symbol id="sarrowbold" table="s" row="260"/>
        <symbol id="sarrowbolditalic" table="s" row="280"/>
        <symbol id="sarrowitalic" table="s" row="270"/>
        <symbol id="sbar" table="s" row="200"/>
        <symbol id="sbarbold" table="s" row="210"/>
        <symbol id="sbarbolditalic" table="s" row="230"/>
        <symbol id="sbaritalic" table="s" row="220"/>
        <symbol id="scaron"/>
        <symbol id="scriptA" table="A" row="330"/>
        <symbol id="scriptC" table="C" row="330"/>
        <symbol id="scriptD" table="D" row="330"/>
        <symbol id="scriptE" table="E" row="330"/>
        <symbol id="scriptF" table="F" row="330"/>
        <symbol id="scriptL" table="L" row="330"/>
        <symbol id="scriptM" table="M" row="330"/>
        <symbol id="scriptP" table="P" row="330"/>
        <symbol id="scriptR" table="R" row="330"/>
        <symbol id="scriptU" table="U" row="330"/>
        <symbol id="scriptV" table="V" row="330"/>
        <symbol id="scripte" table="e" row="330"/>
        <symbol id="scriptl" table="l" row="330"/>
        <symbol id="scriptl_small"/>
        <symbol id="scriptp" table="p" row="330"/>
        <symbol id="scriptw" table="w" row="330"/>
        <symbol id="sdot" table="s" row="130"/>
        <symbol id="section"/>
        <symbol id="semicolon"/>
        <symbol id="semiprod_lf"/>
        <symbol id="semiprod_lf_norm"/>
        <symbol id="semiprod_rt"/>
        <symbol id="semiprod_rt_norm"/>
        <symbol id="separates"/>
        <symbol id="set_minus"/>
        <symbol id="shat" table="s" row="160"/>
        <symbol id="shatbold" table="s" row="170"/>
        <symbol id="shatbolditalic" table="s" row="190"/>
        <symbol id="shatitalic" table="s" row="180"/>
        <symbol id="sigma"/>
        <symbol id="sigma2"/>
        <symbol id="sigma_acc"/>
        <symbol id="sigmabar"/>
        <symbol id="sigmadbldot"/>
        <symbol id="sigmadot"/>
        <symbol id="sigmaf"/>
        <symbol id="sigmahat"/>
        <symbol id="sigmavec"/>
        <symbol id="singlebond"/>
        <symbol id="singlequote"/>
        <symbol id="slash"/>
        <symbol id="slashrtarrow"/>
        <symbol id="smChatitalic"/>
        <symbol id="smYhatitalic"/>
        <symbol id="sm_preview"/>
        <symbol id="smbetahat"/>
        <symbol id="smphatitalic"/>
        <symbol id="space"/>
        <symbol id="space_nobr"/>
        <symbol id="spades"/>
        <symbol id="sphericalangle"/>
        <symbol id="sqrt"/>
        <symbol id="square_black"/>
        <symbol id="square_black_lf"/>
        <symbol id="square_black_nw"/>
        <symbol id="square_black_rt"/>
        <symbol id="square_black_se"/>
        <symbol id="square_root"/>
        <symbol id="square_white"/>
        <symbol id="squareminus"/>
        <symbol id="squareplus"/>
        <symbol id="star"/>
        <symbol id="star_op"/>
        <symbol id="subgr_norm_contains"/>
        <symbol id="subgr_norm_contains_equal"/>
        <symbol id="subset"/>
        <symbol id="subset_neq"/>
        <symbol id="subseteq"/>
        <symbol id="subsetneq"/>
        <symbol id="succeeds"/>
        <symbol id="succeeds_equal"/>
        <symbol id="succeeds_equiv"/>
        <symbol id="succeeds_rel"/>
        <symbol id="sun"/>
        <symbol id="sun_rays"/>
        <symbol id="superset"/>
        <symbol id="supersetneq"/>
        <symbol id="surfaceintegral"/>
        <symbol id="svec" table="s" row="290"/>
        <symbol id="svecbold" table="s" row="300"/>
        <symbol id="svecbolditalic" table="s" row="320"/>
        <symbol id="svecitalic" table="s" row="310"/>
        <symbol id="szlig"/>
        <symbol id="tab"/>
        <symbol id="tarrow" table="t" row="250"/>
        <symbol id="tarrowbold" table="t" row="260"/>
        <symbol id="tarrowitalic" table="t" row="270"/>
        <symbol id="tau"/>
        <symbol id="tau2"/>
        <symbol id="tauarrowbold"/>
        <symbol id="taubar"/>
        <symbol id="taubold"/>
        <symbol id="taudbldot"/>
        <symbol id="taudot"/>
        <symbol id="tauhat"/>
        <symbol id="tauhatbold"/>
        <symbol id="tauvec"/>
        <symbol id="tbar" table="t" row="200"/>
        <symbol id="tbarbold" table="t" row="210"/>
        <symbol id="tbarbolditalic" table="t" row="230"/>
        <symbol id="tbaritalic" table="t" row="220"/>
        <symbol id="that" table="t" row="160"/>
        <symbol id="thatbold" table="t" row="170"/>
        <symbol id="thatbolditalic" table="t" row="190"/>
        <symbol id="thatitalic" table="t" row="180"/>
        <symbol id="thereexists"/>
        <symbol id="therefore"/>
        <symbol id="therefore_sm"/>
        <symbol id="theta"/>
        <symbol id="theta2"/>
        <symbol id="thetabar"/>
        <symbol id="thetabold"/>
        <symbol id="thetadbldot"/>
        <symbol id="thetadot"/>
        <symbol id="thetahat"/>
        <symbol id="thetahatbold"/>
        <symbol id="thetasmall"/>
        <symbol id="thetatilde"/>
        <symbol id="thetavec"/>
        <symbol id="thinsp"/>
        <symbol id="thinsp_acc"/>
        <symbol id="thorn"/>
        <symbol id="tick_grey3"/>
        <symbol id="tilde"/>
        <symbol id="tilde_op"/>
        <symbol id="tilde_sm"/>
        <symbol id="tilde_trp"/>
        <symbol id="times"/>
        <symbol id="times_acc"/>
        <symbol id="topintegral"/>
        <symbol id="trademark"/>
        <symbol id="transform"/>
        <symbol id="triangle_black_down"/>
        <symbol id="triangle_black_lf"/>
        <symbol id="triangle_black_rt"/>
        <symbol id="triangle_black_up"/>
        <symbol id="triangle_ne"/>
        <symbol id="triangle_nw"/>
        <symbol id="triangle_rt"/>
        <symbol id="triangle_se"/>
        <symbol id="triangle_sw"/>
        <symbol id="triangle_white_do"/>
        <symbol id="triangle_white_lf"/>
        <symbol id="triangle_white_rt"/>
        <symbol id="triangle_white_up"/>
        <symbol id="triangledown"/>
        <symbol id="triangleleft"/>
        <symbol id="triangleminus"/>
        <symbol id="triangleplus"/>
        <symbol id="triangleright"/>
        <symbol id="triangleup"/>
        <symbol id="triplebond"/>
        <symbol id="tripleintegral"/>
        <symbol id="tripleprime"/>
        <symbol id="true"/>
        <symbol id="tvec" table="t" row="290"/>
        <symbol id="tvecbold" table="t" row="300"/>
        <symbol id="tvecbolditalic" table="t" row="320"/>
        <symbol id="tvecitalic" table="t" row="310"/>
        <symbol id="u-umlaut" table="u" row="120"/>
        <symbol id="uacute" table="u" row="100"/>
        <symbol id="uarrowbold" table="u" row="260"/>
        <symbol id="uarrowbolditalic" table="u" row="280"/>
        <symbol id="uarrowitalic" table="u" row="270"/>
        <symbol id="ubar" table="u" row="200"/>
        <symbol id="ubarbold" table="u" row="210"/>
        <symbol id="ubarbolditalic" table="u" row="230"/>
        <symbol id="ubaritalic" table="u" row="220"/>
        <symbol id="ubold" table="u" row="90"/>
        <symbol id="ucirc"/>
        <symbol id="ugrave" table="u" row="110"/>
        <symbol id="uhat" table="u" row="160"/>
        <symbol id="uhatbold" table="u" row="170"/>
        <symbol id="uhatbolditalic" table="u" row="190"/>
        <symbol id="uhatitalic" table="u" row="180"/>
        <symbol id="underscore"/>
        <symbol id="undertie"/>
        <symbol id="union"/>
        <symbol id="uparrow"/>
        <symbol id="updoublearrow"/>
        <symbol id="updownarrow"/>
        <symbol id="upleftarrow"/>
        <symbol id="uprightarrow"/>
        <symbol id="upsilon"/>
        <symbol id="upsilon2"/>
        <symbol id="upsilonbar"/>
        <symbol id="upsilondbldot"/>
        <symbol id="upsilondot"/>
        <symbol id="upsilonhat"/>
        <symbol id="upsilonvec"/>
        <symbol id="uptack"/>
        <symbol id="utilde" table="u" row="150"/>
        <symbol id="uuml" table="u" row="120"/>
        <symbol id="uvec" table="u" row="290"/>
        <symbol id="uvecbolditalic" table="u" row="320"/>
        <symbol id="uvecitalic" table="u" row="310"/>
        <symbol id="v2bar"/>
        <symbol id="varrow" table="v" row="250"/>
        <symbol id="varrowbold" table="v" row="260"/>
        <symbol id="varrowbolditalic" table="v" row="280"/>
        <symbol id="varrowitalic" table="v" row="270"/>
        <symbol id="vas_rho"/>
        <symbol id="vbar" table="v" row="200"/>
        <symbol id="vbarbold" table="v" row="210"/>
        <symbol id="vbarbolditalic" table="v" row="230"/>
        <symbol id="vbaritalic" table="v" row="220"/>
        <symbol id="vbold" table="v" row="90"/>
        <symbol id="vecAbold" table="A" row="261"/>
        <symbol id="vecBbold" table="B" row="261"/>
        <symbol id="vecCbold" table="C" row="261"/>
        <symbol id="vecDbold" table="D" row="261"/>
        <symbol id="vecEbold" table="E" row="261"/>
        <symbol id="vecFbold" table="F" row="261"/>
        <symbol id="vecGbold" table="G" row="261"/>
        <symbol id="vecHbold" table="H" row="261"/>
        <symbol id="vecIbold" table="I" row="261"/>
        <symbol id="vecJbold" table="J" row="261"/>
        <symbol id="vecKbold" table="K" row="261"/>
        <symbol id="vecLbold" table="L" row="261"/>
        <symbol id="vecMbold" table="M" row="261"/>
        <symbol id="vecNbold" table="N" row="261"/>
        <symbol id="vecObold" table="O" row="261"/>
        <symbol id="vecPbold" table="P" row="261"/>
        <symbol id="vecQbold" table="Q" row="261"/>
        <symbol id="vecRbold" table="R" row="261"/>
        <symbol id="vecSbold" table="S" row="261"/>
        <symbol id="vecTbold" table="T" row="261"/>
        <symbol id="vecUbold" table="U" row="261"/>
        <symbol id="vecVbold" table="V" row="261"/>
        <symbol id="vecWbold" table="W" row="261"/>
        <symbol id="vecXbold" table="X" row="261"/>
        <symbol id="vecYbold" table="Y" row="261"/>
        <symbol id="vecZbold" table="Z" row="261"/>
        <symbol id="vecabold" table="a" row="261"/>
        <symbol id="vecbbold" table="b" row="261"/>
        <symbol id="veccbold" table="c" row="261"/>
        <symbol id="vecdbold" table="d" row="261"/>
        <symbol id="vecebold" table="e" row="261"/>
        <symbol id="vecfbold" table="f" row="261"/>
        <symbol id="vecgbold" table="g" row="261"/>
        <symbol id="vechbold" table="h" row="261"/>
        <symbol id="vecibold" table="i" row="261"/>
        <symbol id="vecjbold" table="j" row="261"/>
        <symbol id="veckbold" table="k" row="261"/>
        <symbol id="veclbold" table="l" row="261"/>
        <symbol id="vecmbold" table="m" row="261"/>
        <symbol id="vecnbold" table="n" row="261"/>
        <symbol id="vecobold" table="o" row="261"/>
        <symbol id="vecpbold" table="p" row="261"/>
        <symbol id="vecqbold" table="q" row="261"/>
        <symbol id="vecrbold" table="r" row="261"/>
        <symbol id="vecsbold" table="s" row="261"/>
        <symbol id="vecstart"/>
        <symbol id="vecstop"/>
        <symbol id="vectbold" table="t" row="261"/>
        <symbol id="vecthetahat"/>
        <symbol id="vecubold" table="u" row="261"/>
        <symbol id="vecvbold" table="v" row="261"/>
        <symbol id="vecwbold" table="w" row="261"/>
        <symbol id="vecxbold" table="x" row="261"/>
        <symbol id="vecybold" table="y" row="261"/>
        <symbol id="veczbold" table="z" row="261"/>
        <symbol id="vellipsis"/>
        <symbol id="vhat" table="v" row="160"/>
        <symbol id="vhatbold" table="v" row="170"/>
        <symbol id="vhatbolditalic" table="v" row="190"/>
        <symbol id="vhatitalic" table="v" row="180"/>
        <symbol id="volumeintegral"/>
        <symbol id="vtilde" table="v" row="150"/>
        <symbol id="vvec" table="v" row="290"/>
        <symbol id="vvecbold" table="v" row="300"/>
        <symbol id="vvecbolditalic" table="v" row="320"/>
        <symbol id="vvecitalic" table="v" row="310"/>
        <symbol id="warrow" table="w" row="250"/>
        <symbol id="warrowbold" table="w" row="260"/>
        <symbol id="warrowbolditalic" table="w" row="280"/>
        <symbol id="warrowitalic" table="w" row="270"/>
        <symbol id="wbar" table="w" row="200"/>
        <symbol id="wbarbold" table="w" row="210"/>
        <symbol id="wbarbolditalic" table="w" row="230"/>
        <symbol id="wbaritalic" table="w" row="220"/>
        <symbol id="wedgearrow"/>
        <symbol id="what" table="w" row="160"/>
        <symbol id="whatbold" table="w" row="170"/>
        <symbol id="whatbolditalic" table="w" row="190"/>
        <symbol id="whatitalic" table="w" row="180"/>
        <symbol id="wvec" table="w" row="290"/>
        <symbol id="wvecbold" table="w" row="300"/>
        <symbol id="wvecbolditalic" table="w" row="320"/>
        <symbol id="wvecitalic" table="w" row="310"/>
        <symbol id="xarrow" table="x" row="250"/>
        <symbol id="xarrowbold" table="x" row="260"/>
        <symbol id="xarrowbolditalic" table="x" row="280"/>
        <symbol id="xarrowitalic" table="x" row="270"/>
        <symbol id="xbar" table="x" row="200"/>
        <symbol id="xbar_acc"/>
        <symbol id="xbarbold" table="x" row="210"/>
        <symbol id="xbarbolditalic" table="x" row="230"/>
        <symbol id="xbaritalic" table="x" row="220"/>
        <symbol id="xdblbar" table="x" row="240"/>
        <symbol id="xdbldot" table="x" row="140"/>
        <symbol id="xdot" table="x" row="130"/>
        <symbol id="xhat" table="x" row="160"/>
        <symbol id="xhatbold" table="x" row="170"/>
        <symbol id="xhatbolditalic" table="x" row="190"/>
        <symbol id="xhatbolditalicred"/>
        <symbol id="xhatitalic" table="x" row="180"/>
        <symbol id="xhatitalicred"/>
        <symbol id="xi"/>
        <symbol id="xi2"/>
        <symbol id="xibar"/>
        <symbol id="xidbldot"/>
        <symbol id="xidot"/>
        <symbol id="xihat"/>
        <symbol id="xivec"/>
        <symbol id="xor"/>
        <symbol id="xtilde" table="x" row="150"/>
        <symbol id="xvec" table="x" row="290"/>
        <symbol id="xvecbold" table="x" row="300"/>
        <symbol id="xvecbolditalic" table="x" row="320"/>
        <symbol id="xvecitalic" table="x" row="310"/>
        <symbol id="yacute" table="y" row="100"/>
        <symbol id="yarrow" table="y" row="250"/>
        <symbol id="yarrowbold" table="y" row="260"/>
        <symbol id="yarrowbolditalic" table="y" row="280"/>
        <symbol id="yarrowitalic" table="y" row="270"/>
        <symbol id="ybar" table="y" row="200"/>
        <symbol id="ybar_acc"/>
        <symbol id="ybarbold" table="y" row="210"/>
        <symbol id="ybarbolditalic" table="y" row="230"/>
        <symbol id="ybaritalic" table="y" row="220"/>
        <symbol id="ydblbar" table="y" row="240"/>
        <symbol id="ydbldot" table="y" row="140"/>
        <symbol id="ydot" table="y" row="130"/>
        <symbol id="yen"/>
        <symbol id="yhat" table="y" row="160"/>
        <symbol id="yhatbold" table="y" row="170"/>
        <symbol id="yhatbolditalic" table="y" row="190"/>
        <symbol id="yhatbolditalicred"/>
        <symbol id="yhatitalic" table="y" row="180"/>
        <symbol id="yhatitalicred"/>
        <symbol id="ytilde" table="y" row="150"/>
        <symbol id="yuml" table="y" row="120"/>
        <symbol id="yvec" table="y" row="290"/>
        <symbol id="yvecbold" table="y" row="300"/>
        <symbol id="yvecbolditalic" table="y" row="320"/>
        <symbol id="yvecitalic" table="y" row="310"/>
        <symbol id="zarrow" table="z" row="250"/>
        <symbol id="zarrowbold" table="z" row="260"/>
        <symbol id="zarrowbolditalic" table="z" row="280"/>
        <symbol id="zarrowitalic" table="z" row="270"/>
        <symbol id="zbar" table="z" row="200"/>
        <symbol id="zbarbold" table="z" row="210"/>
        <symbol id="zbarbolditalic" table="z" row="230"/>
        <symbol id="zbaritalic" table="z" row="220"/>
        <symbol id="zdbldot" table="z" row="140"/>
        <symbol id="zdot" table="z" row="130"/>
        <symbol id="zeta"/>
        <symbol id="zeta2"/>
        <symbol id="zetabar"/>
        <symbol id="zetadbldot"/>
        <symbol id="zetadot"/>
        <symbol id="zetahat"/>
        <symbol id="zetavec"/>
        <symbol id="zhat" table="z" row="160"/>
        <symbol id="zhatbold" table="z" row="170"/>
        <symbol id="zhatbolditalic" table="z" row="190"/>
        <symbol id="zhatbolditalicred"/>
        <symbol id="zhatitalic" table="z" row="180"/>
        <symbol id="zhatitalicred"/>
        <symbol id="zigzagarrow"/>
        <symbol id="zonar"/>
        <symbol id="zvec" table="z" row="290"/>
        <symbol id="zvecbold" table="z" row="300"/>
        <symbol id="zvecbolditalic" table="z" row="320"/>
        <symbol id="zvecitalic" table="z" row="310"/>
    </xsl:variable>
    
    <xsl:variable name="allsymbols">
        <xsl:apply-templates select="//tr[./td]"/>
    </xsl:variable>
    
    <xsl:template match="/*" xml:space="preserve">
<reference id="symbols_symbollist" xml:lang="en-us">
    <title>Symbols Content for Re-Use</title>
    <shortdesc>This topic is resource-only.</shortdesc>
    <refbody>
        <section>
            <p>To update this topic:</p>
            <ol>
                <li>Download http://phantom.office.webassign.net/webtool/symbols.html.</li>
                <li>"Clean up" the file (e.g., change &lt;br> to &lt;br/>).</li>
                <li>Parse the file with parseSymbolsList.xsl to this topic.</li>
            </ol>
        </section>
    

        <!-- 
            
            
        To group and sort items correctly with XSL (and avoid a lot of manual stuff):
        1) Add @table and @row attributes to <symbol> data above
      X 2) Parse <xsl:apply-templates select="//tr[./td]"/> into a variable (allsymbols)
      X 3) Incorporate @row & @table attributes in <xsl:template match="tr[./td]" xml:space="preserve">
      X 4) For each table, copy and sort the appropriate rows from $allsymbols
      X 5) Report any strow elements in $allsymbols that don't have @table & @row (these will be new) 
        
        
        -->
        <xsl:for-each-group select="$allsymbols/row" group-by="@table">
            <xsl:sort select="@table"/>
            <section id="{normalize-space(current-grouping-key())}">
                <title><xsl:value-of select="normalize-space(current-grouping-key())"/></title>
                <simpletable>
                    <xsl:for-each select="current-group()">
                        <xsl:sort select="@row"/>
                        <xsl:copy-of select="strow"/>
                    </xsl:for-each>
                </simpletable>
            </section>
        </xsl:for-each-group>
    </refbody>
</reference>
    </xsl:template>
    
    <xsl:template match="tr[./td]" xml:space="preserve">
        <xsl:param name="symbolid" select="replace( td[1]/text(), '\s*&lt;s:(.*?)&gt;\s*', '$1')"/>
        <xsl:param name="knowndata" select="$knownIDs/symbol[@id=$symbolid]"/>
        <xsl:param name="table">
            <xsl:choose>
                <xsl:when test="$knowndata/@table"><xsl:value-of select="$knowndata/@table"/></xsl:when>
                <xsl:otherwise>unknown</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="row">
            <xsl:choose>
                <xsl:when test="$knowndata/@row"><xsl:value-of select="$knowndata/@row"/></xsl:when>
                <xsl:otherwise>9999</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <row id="{$symbolid}" table="{$table}" row="{$row}">
            <strow id="{$symbolid}">
                <xsl:apply-templates select="td[2]">
                    <xsl:with-param name="symbolid" select="$symbolid"/>
                </xsl:apply-templates>
                <stentry>
                    <codeph id="{concat($symbolid,'_code')}">&lt;s:<xsl:value-of select="$symbolid"/>&gt;</codeph>
                </stentry>
            </strow>
        </row>
    </xsl:template>
    
    <xsl:template match="td[2]">
        <xsl:param name="symbolid"/>
        <stentry>
            <ph id="{concat($symbolid,'_symbol')}">
                <xsl:apply-templates mode="symboldef"/>
            </ph>
        </stentry>
    </xsl:template>
    
    <xsl:template match="span" mode="symboldef">
        <ph>
            <xsl:apply-templates mode="symboldef"/>
        </ph>
    </xsl:template>
    
    <xsl:template match="strong" mode="symboldef">
        <b>
            <xsl:apply-templates mode="symboldef"/>
        </b>
    </xsl:template>
    
    <xsl:template match="text()" mode="symboldef">
        <xsl:choose>
            <xsl:when test="../@style and normalize-space(.) != ''">
                <xsl:call-template name="styledText">
                    <xsl:with-param name="text" select="normalize-space(.)"/>
                    <xsl:with-param name="style" select="../@style"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="img" mode="symboldef">
        <xsl:param name="src" select="@src"/>
        <xsl:param name="alt" select="@alt"/>
        <image href="{$src}"><alt><xsl:value-of select="$alt"></xsl:value-of></alt></image>
    </xsl:template>
    
    <xsl:template match="*" mode="symboldef">
        <xsl:param name="element" select="local-name(.)"/>
        <ph outputclass="{$element}">
            <xsl:apply-templates mode="symboldef"/>
        </ph>
    </xsl:template>
    
    <xsl:function name="fn:parsestyle">
        <xsl:param name="stylestring"/>
        <xsl:variable name="name" select="normalize-space(replace($stylestring,':[^:]+$',''))"/>
        <xsl:variable name="value" select="normalize-space(replace($stylestring,'^[^:]+:',''))"/>
        <xsl:choose>
            <xsl:when test="$name='font-family' and matches($value,'(Cambria|Georgia|[,\s]serif)')">
                <outputclass><xsl:text> Math </xsl:text></outputclass>
            </xsl:when>
            <xsl:when test="$name='font-style' and $value='italic'">
                <element>i</element>
            </xsl:when>
            <xsl:when test="$name='font-weight' and matches($value,'bold')">
                <element>b</element>
            </xsl:when>
            <xsl:when test="$name='text-decoration' and $value='overline'">
                <outputclass><xsl:text> overline </xsl:text></outputclass>
            </xsl:when>
            <xsl:when test="$name='font-variant' and $value='small-caps'">
                <outputclass><xsl:text> small-caps </xsl:text></outputclass>
            </xsl:when>
            <xsl:when test="$name='color'">
                <outputclass><xsl:value-of select="concat('color=',$value)"/></outputclass>
            </xsl:when>
            <xsl:when test="$name='font'">
                <xsl:if test="matches($value,'italic')">
                    <element>i</element>
                </xsl:if>
                <xsl:if test="matches($value,'bold')">
                    <element>b</element>
                </xsl:if>
                <xsl:if test="matches($value,'(Cambria|Georgia|[,\s]serif)')">
                    <outputclass><xsl:text> Math </xsl:text></outputclass>
                </xsl:if>
            </xsl:when>
            <!-- Ignore cases -->
            <xsl:when test="$name='font-style' and $value='normal'"/>
            <xsl:when test="$name='font-family' and matches($value,'(Trebuchet|Lucida|[,\s]sans-serif)')"/>
            <xsl:when test="$name='font-size'"/>
            <xsl:when test="$name='text-align'"/>
            <xsl:when test="$name='padding'"/>
            <xsl:when test="$name='cursor'"/>
            <xsl:when test="$name='position'"/>
            <xsl:when test="$name='left'"/>
            <xsl:when test="$name='right'"/>
            <xsl:when test="$name='width'"/>
            <xsl:when test="$name='display'"/>
            <xsl:when test="$name='white-space'"/>
            <xsl:when test="$name=''"/>
            <xsl:otherwise>
                <data>
                    <xsl:attribute name="name" select="$name"/>
                    <xsl:attribute name="value" select="$value"/>
                </data>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:template name="styledText">
        <xsl:param name="style"/>
        <xsl:param name="text"/>
        <xsl:param name="styles" select="distinct-values(tokenize($style,'[;]'))"/>
        <xsl:param name="parsedstyles">
            <xsl:for-each select="$styles">
                <xsl:copy-of select="fn:parsestyle(.)"/>
            </xsl:for-each>
        </xsl:param>
        <xsl:param name="outputclass">
            <xsl:value-of select="$parsedstyles/outputclass/text()"/>
        </xsl:param>
        <xsl:param name="elements">
            <xsl:copy-of select="$parsedstyles/element"/>
        </xsl:param>
        <xsl:param name="styledata" select="$parsedstyles/data"/>
        <xsl:if test="string-length(normalize-space($outputclass))>0">
            <xsl:attribute name="outputclass" select="normalize-space($outputclass)"/>
        </xsl:if>
        <xsl:copy-of select="$styledata"/>
        <xsl:choose>
            <xsl:when test="count($elements/element)=1">
                <xsl:element name="{$elements[1]/element/text()}">
                    <xsl:value-of select="$text"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="count($elements/element)=2">
                <xsl:element name="{$elements/element[1]/text()}">
                    <xsl:element name="{$elements/element[2]/text()}">
                        <xsl:value-of select="$text"/>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
</xsl:stylesheet>