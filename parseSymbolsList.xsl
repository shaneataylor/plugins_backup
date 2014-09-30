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
        <symbol table="Numbers" row="" id="0arrow" description=""/>
        <symbol table="Numbers" row="" id="0hat" description=""/>
        <symbol table="Other_Letters" row="" id="AElig" description=""/>
        <symbol table="Other_Letters" row="" id="ETH" description=""/>
        <symbol table="Other_Letters" row="" id="OElig" description=""/>
        <symbol table="O" row="" id="Ocirc" description=""/>
        <symbol table="" row="" id="PQvecitalic" description=""/>
        <symbol table="" row="" id="PRvecitalic" description=""/>
        <symbol table="" row="" id="abline" description=""/>
        <symbol table="Other_Letters" row="" id="aelig" description=""/>
        <symbol table="Miscellaneous" row="" id="ankh" description=""/>
        <symbol table="" row="" id="arc" description=""/>
        <symbol table="" row="" id="arc_btm" description=""/>
        <symbol table="" row="" id="arc_ne" description=""/>
        <symbol table="" row="" id="arc_nw" description=""/>
        <symbol table="" row="" id="arc_se" description=""/>
        <symbol table="" row="" id="arc_sw" description=""/>
        <symbol table="" row="" id="arc_top" description=""/>
        <symbol table="" row="" id="assertion" description=""/>
        <symbol table="" row="" id="asterism" description=""/>
        <symbol table="" row="" id="because" description=""/>
        <symbol table="" row="" id="bicond" description=""/>
        <symbol table="" row="" id="bicond_acc" description=""/>
        <symbol table="" row="" id="blackdot" description=""/>
        <symbol table="" row="" id="bowtie_op" description=""/>
        <symbol table="" row="" id="brokenbar" description=""/>
        <symbol table="Ellipses" row="" id="cdots" description=""/>
        <symbol table="Punctuation" row="" id="cedil" description=""/>
        <symbol table="" row="" id="checklteq" description=""/>
        <symbol table="Miscellaneous" row="" id="circle" description=""/>
        <symbol table="Miscellaneous" row="" id="circleasterisk" description=""/>
        <symbol table="Miscellaneous" row="" id="circledash" description=""/>
        <symbol table="Miscellaneous" row="" id="circledivide" description=""/>
        <symbol table="Miscellaneous" row="" id="circledot" description=""/>
        <symbol table="Miscellaneous" row="" id="circlering" description=""/>
        <symbol table="Miscellaneous" row="" id="circletimes" description=""/>
        <symbol table="Miscellaneous" row="" id="cleardot" description="clear dot"/>
        <symbol table="Miscellaneous" row="" id="clearline" description="clear line"/>
        <symbol table="" row="" id="complement" description=""/>
        <symbol table="" row="" id="correspondence" description=""/>
        <symbol table="" row="" id="corresponds" description=""/>
        <symbol table="" row="" id="dbl_vertical" description=""/>
        <symbol table="" row="" id="difference" description=""/>
        <symbol table="" row="" id="downtack" description=""/>
        <symbol table="Chemistry" row="" id="eertarrow" description=""/>
        <symbol table="" row="" id="estimated" description=""/>
        <symbol table="" row="" id="estimates" description=""/>
        <symbol table="" row="" id="fdash" description=""/>
        <symbol table="" row="" id="fnof" description=""/>
        <symbol table="" row="" id="hor_bar" description=""/>
        <symbol table="" row="" id="identical" description=""/>
        <symbol table="" row="" id="intercalate" description=""/>
        <symbol table="" row="" id="inv_ohm" description=""/>
        <symbol table="" row="" id="lefttack" description=""/>
        <symbol table="" row="" id="lowast" description=""/>
        <symbol table="Miscellaneous" row="" id="lozenge" description=""/>
        <symbol table="" row="" id="macr" description=""/>
        <symbol table="Math" row="" id="measuredangle" description=""/>
        <symbol table="Punctuation" row="" id="middot" description=""/>
        <symbol table="Punctuation" row="" id="middot_acc" description=""/>
        <symbol table="Punctuation" row="" id="middot_op" description=""/>
        <symbol table="" row="" id="ml" description=""/>
        <symbol table="" row="" id="models" description=""/>
        <symbol table="" row="" id="nablaarrow" description=""/>
        <symbol table="" row="" id="nand" description=""/>
        <symbol table="" row="" id="naught" description=""/>
        <symbol table="" row="" id="naught_hi" description=""/>
        <symbol table="" row="" id="naught_lo" description=""/>
        <symbol table="" row="" id="no" description=""/>
        <symbol table="" row="" id="nor" description=""/>
        <symbol table="" row="" id="norm_subgr" description=""/>
        <symbol table="" row="" id="norm_subgr_equal" description=""/>
        <symbol table="" row="" id="oaline" description=""/>
        <symbol table="Other_Letters" row="" id="oelig" description=""/>
        <symbol table="Miscellaneous" row="" id="orb_d" description=""/>
        <symbol table="Miscellaneous" row="" id="orb_e" description=""/>
        <symbol table="Miscellaneous" row="" id="orb_none" description=""/>
        <symbol table="Miscellaneous" row="" id="orb_u" description=""/>
        <symbol table="Miscellaneous" row="" id="orb_ud" description=""/>
        <symbol table="" row="" id="ordf" description=""/>
        <symbol table="" row="" id="ordm" description=""/>
        <symbol table="" row="" id="overtie" description=""/>
        <symbol table="Lines" row="" id="parabdown" description=""/>
        <symbol table="Lines" row="" id="parabup" description=""/>
        <symbol table="" row="" id="pipe" description=""/>
        <symbol table="" row="" id="ratio" description=""/>
        <symbol table="Units" row="" id="red_deg" description=""/>
        <symbol table="" row="" id="reference" description=""/>
        <symbol table="" row="" id="reg" description=""/>
        <symbol table="Punctuation" row="" id="registered" description=""/>
        <symbol table="Math" row="" id="rev_doubleprime" description=""/>
        <symbol table="Math" row="" id="rev_prime" description=""/>
        <symbol table="Math" row="" id="rev_tripleprime" description=""/>
        <symbol table="" row="" id="right_dbl_bar" description=""/>
        <symbol table="Punctuation" row="" id="rightbracket" description=""/>
        <symbol table="Punctuation" row="" id="rightcurly" description=""/>
        <symbol table="Arrows" row="" id="rightdoublearrow" description=""/>
        <symbol table="" row="" id="rightdownvector" description=""/>
        <symbol table="Punctuation" row="" id="rightparens" description=""/>
        <symbol table="" row="" id="righttack" description=""/>
        <symbol table="Punctuation" row="" id="ring_op" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowE" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowF" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowL" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowPt" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowp" description=""/>
        <symbol table="Math" row="" id="semiprod_lf" description=""/>
        <symbol table="Math" row="" id="semiprod_lf_norm" description=""/>
        <symbol table="Math" row="" id="semiprod_rt" description=""/>
        <symbol table="Math" row="" id="semiprod_rt_norm" description=""/>
        <symbol table="Math" row="" id="separates" description=""/>
        <symbol table="Math" row="" id="set_minus" description=""/>
        <symbol table="Punctuation" row="" id="slash" description=""/>
        <symbol table="Arrows" row="" id="slashrtarrow" description=""/>
        <symbol table="C" row="" id="smChatitalic" description=""/>
        <symbol table="Y" row="" id="smYhatitalic" description=""/>
        <symbol table="Miscellaneous" row="" id="sm_preview" description=""/>
        <symbol table="Beta" row="" id="smbetahat" description=""/>
        <symbol table="P" row="" id="smphatitalic" description=""/>
        <symbol table="Miscellaneous" row="" id="spades" description=""/>
        <symbol table="" row="" id="sphericalangle" description=""/>
        <symbol table="Miscellaneous" row="" id="square_black" description=""/>
        <symbol table="Miscellaneous" row="" id="square_black_lf" description=""/>
        <symbol table="Miscellaneous" row="" id="square_black_nw" description=""/>
        <symbol table="Miscellaneous" row="" id="square_black_rt" description=""/>
        <symbol table="Miscellaneous" row="" id="square_black_se" description=""/>
        <symbol table="Math" row="" id="square_root" description=""/>
        <symbol table="Miscellaneous" row="" id="square_white" description=""/>
        <symbol table="Miscellaneous" row="" id="star" description=""/>
        <symbol table="Miscellaneous" row="" id="star_op" description=""/>
        <symbol table="" row="" id="subgr_norm_contains" description=""/>
        <symbol table="" row="" id="subgr_norm_contains_equal" description=""/>
        <symbol table="" row="" id="succeeds" description=""/>
        <symbol table="" row="" id="succeeds_equal" description=""/>
        <symbol table="" row="" id="succeeds_equiv" description=""/>
        <symbol table="" row="" id="succeeds_rel" description=""/>
        <symbol table="Miscellaneous" row="" id="sun" description=""/>
        <symbol table="Miscellaneous" row="" id="sun_rays" description=""/>
        <symbol table="" row="" id="superset" description=""/>
        <symbol table="" row="" id="supersetneq" description=""/>
        <symbol table="Math" row="" id="surfaceintegral" description=""/>
        <symbol table="German" row="" id="szlig" description=""/>
        <symbol table="" row="" id="therefore_sm" description=""/>
        <symbol table="" row="" id="tick_grey3" description=""/>
        <symbol table="" row="" id="tilde" description=""/>
        <symbol table="" row="" id="tilde_op" description=""/>
        <symbol table="" row="" id="tilde_sm" description=""/>
        <symbol table="" row="" id="tilde_trp" description=""/>
        <symbol table="Math" row="" id="topintegral" description=""/>
        <symbol table="Punctuation" row="" id="trademark" description=""/>
        <symbol table="" row="" id="transform" description=""/>
        <symbol table="" row="" id="true" description=""/>
        <symbol table="" row="" id="undertie" description=""/>
        <symbol table="" row="" id="uptack" description=""/>
        <symbol table="" row="" id="v2bar" description=""/>
        <symbol table="" row="" id="vas_rho" description=""/>
        <symbol table="" row="" id="vecthetahat" description=""/>
        <symbol table="" row="" id="volumeintegral" description=""/>
        <symbol table="" row="" id="xbar_acc" description=""/>
        <symbol table="" row="" id="xor" description=""/>
        <symbol table="Miscellaneous" row="" id="zigzagarrow" description=""/>
        <symbol table="" row="" id="zonar" description=""/>
        <symbol table="A" row="" id="Acirc" description=""/>
        <symbol table="A" row="" id="Aring" description=""/>
        <symbol table="A" row="" id="acirc" description=""/>
        <symbol table="A" row="" id="aring" description=""/>
        <symbol table="A" row="" id="circleAsm" description=""/>
        <symbol table="A" row="100" id="Aacute" description=""/>
        <symbol table="A" row="100" id="aacute" description=""/>
        <symbol table="A" row="110" id="Agrave" description=""/>
        <symbol table="A" row="110" id="agrave" description=""/>
        <symbol table="A" row="120" id="Auml" description=""/>
        <symbol table="A" row="120" id="a-umlaut" description=""/>
        <symbol table="A" row="120" id="auml" description=""/>
        <symbol table="A" row="150" id="Atilde" description=""/>
        <symbol table="A" row="150" id="atilde" description=""/>
        <symbol table="A" row="160" id="Ahat" description=""/>
        <symbol table="A" row="160" id="ahat" description=""/>
        <symbol table="A" row="170" id="Ahatbold" description=""/>
        <symbol table="A" row="170" id="ahatbold" description=""/>
        <symbol table="A" row="180" id="Ahatitalic" description=""/>
        <symbol table="A" row="180" id="ahatitalic" description=""/>
        <symbol table="A" row="190" id="Ahatbolditalic" description=""/>
        <symbol table="A" row="190" id="ahatbolditalic" description=""/>
        <symbol table="A" row="200" id="Abar" description=""/>
        <symbol table="A" row="200" id="abar" description=""/>
        <symbol table="A" row="210" id="Abarbold" description=""/>
        <symbol table="A" row="210" id="abarbold" description=""/>
        <symbol table="A" row="220" id="Abaritalic" description=""/>
        <symbol table="A" row="220" id="abaritalic" description=""/>
        <symbol table="A" row="230" id="Abarbolditalic" description=""/>
        <symbol table="A" row="230" id="abarbolditalic" description=""/>
        <symbol table="A" row="250" id="Aarrow" description=""/>
        <symbol table="A" row="250" id="aarrow" description=""/>
        <symbol table="A" row="260" id="Aarrowbold" description=""/>
        <symbol table="A" row="260" id="aarrowbold" description=""/>
        <symbol table="A" row="261" id="vecAbold" description=""/>
        <symbol table="A" row="261" id="vecabold" description=""/>
        <symbol table="A" row="270" id="Aarrowitalic" description=""/>
        <symbol table="A" row="270" id="aarrowitalic" description=""/>
        <symbol table="A" row="280" id="Aarrowbolditalic" description=""/>
        <symbol table="A" row="280" id="aarrowbolditalic" description=""/>
        <symbol table="A" row="290" id="Avec" description=""/>
        <symbol table="A" row="290" id="avec" description=""/>
        <symbol table="A" row="300" id="Avecbold" description=""/>
        <symbol table="A" row="300" id="avecbold" description=""/>
        <symbol table="A" row="310" id="Avecitalic" description=""/>
        <symbol table="A" row="310" id="avecitalic" description=""/>
        <symbol table="A" row="320" id="Avecbolditalic" description=""/>
        <symbol table="A" row="320" id="avecbolditalic" description=""/>
        <symbol table="A" row="330" id="scriptA" description=""/>
        <symbol table="A" row="340" id="circleA" description=""/>
        <symbol table="Alpha" row="100" id="Alpha" description=""/>
        <symbol table="Alpha" row="100" id="Alpha2" description=""/>
        <symbol table="Alpha" row="100" id="Alphabar" description=""/>
        <symbol table="Alpha" row="100" id="Alphadbldot" description=""/>
        <symbol table="Alpha" row="100" id="Alphadot" description=""/>
        <symbol table="Alpha" row="100" id="Alphahat" description=""/>
        <symbol table="Alpha" row="100" id="Alphavec" description=""/>
        <symbol table="Alpha" row="100" id="alpha" description=""/>
        <symbol table="Alpha" row="100" id="alpha2" description=""/>
        <symbol table="Alpha" row="100" id="alphaarrowbold" description=""/>
        <symbol table="Alpha" row="100" id="alphabar" description=""/>
        <symbol table="Alpha" row="100" id="alphabold" description=""/>
        <symbol table="Alpha" row="100" id="alphadbldot" description=""/>
        <symbol table="Alpha" row="100" id="alphadot" description=""/>
        <symbol table="Alpha" row="100" id="alphahat" description=""/>
        <symbol table="Alpha" row="100" id="alphavec" description=""/>
        <symbol table="Arrows" row="" id="SEarrow" description=""/>
        <symbol table="Arrows" row="" id="SWarrow" description=""/>
        <symbol table="Arrows" row="" id="rightarrow" description=""/>
        <symbol table="Arrows" row="" id="rightarrow_acc" description=""/>
        <symbol table="Arrows" row="" id="uparrow" description=""/>
        <symbol table="Arrows" row="" id="updoublearrow" description=""/>
        <symbol table="Arrows" row="" id="updownarrow" description=""/>
        <symbol table="Arrows" row="" id="upleftarrow" description=""/>
        <symbol table="Arrows" row="" id="uprightarrow" description=""/>
        <symbol table="Arrows" row="" id="rtarrow" description=""/>
        <symbol table="Arrows" row="" id="rtarrowlong" description=""/>
        <symbol table="Arrows" row="" id="NEarrow" description=""/>
        <symbol table="Arrows" row="" id="NWarrow" description=""/>
        <symbol table="Arrows" row="" id="arrow_circ_anti" description=""/>
        <symbol table="Arrows" row="" id="arrow_circ_clock" description=""/>
        <symbol table="Arrows" row="" id="arrow_dbl_do" description=""/>
        <symbol table="Arrows" row="" id="arrow_dbl_ne" description=""/>
        <symbol table="Arrows" row="" id="arrow_dbl_nw" description=""/>
        <symbol table="Arrows" row="" id="arrow_dbl_se" description=""/>
        <symbol table="Arrows" row="" id="arrow_dbl_sw" description=""/>
        <symbol table="Arrows" row="" id="arrow_dbl_ver" description=""/>
        <symbol table="Arrows" row="" id="arrow_do" description=""/>
        <symbol table="Arrows" row="" id="arrow_do_do" description=""/>
        <symbol table="Arrows" row="" id="arrow_do_lf" description=""/>
        <symbol table="Arrows" row="" id="arrow_do_rt" description=""/>
        <symbol table="Arrows" row="" id="arrow_lf_lf" description=""/>
        <symbol table="Arrows" row="" id="arrow_lf_rt" description=""/>
        <symbol table="Arrows" row="" id="arrow_rt_rt" description=""/>
        <symbol table="Arrows" row="" id="arrow_semi_anti" description=""/>
        <symbol table="Arrows" row="" id="arrow_semi_clock" description=""/>
        <symbol table="Arrows" row="" id="arrow_trp_lf" description=""/>
        <symbol table="Arrows" row="" id="arrow_trp_rt" description=""/>
        <symbol table="Arrows" row="" id="arrow_up_up" description=""/>
        <symbol table="Arrows" row="" id="arrowbold" description=""/>
        <symbol table="Arrows" row="" id="arrowboldleft" description=""/>
        <symbol table="Arrows" row="" id="curvedleftarrow" description=""/>
        <symbol table="Arrows" row="" id="curvedrtarrow" description=""/>
        <symbol table="Arrows" row="" id="curvedupdownarrow" description=""/>
        <symbol table="Arrows" row="" id="dgarrowdnrt" description=""/>
        <symbol table="Arrows" row="" id="dgarrowuprt" description=""/>
        <symbol table="Arrows" row="" id="harp_do_lf" description=""/>
        <symbol table="Arrows" row="" id="harp_lf_do" description=""/>
        <symbol table="Arrows" row="" id="harp_lf_rt" description=""/>
        <symbol table="Arrows" row="" id="harp_lf_up" description=""/>
        <symbol table="Arrows" row="" id="harp_rt_do" description=""/>
        <symbol table="Arrows" row="" id="harp_rt_up" description=""/>
        <symbol table="Arrows" row="" id="harp_up_rt" description=""/>
        <symbol table="Arrows" row="" id="leftarrow" description=""/>
        <symbol table="Arrows" row="" id="leftdoublearrow" description=""/>
        <symbol table="Arrows" row="" id="leftrtarrow" description=""/>
        <symbol table="Arrows" row="" id="leftupvector" description=""/>
        <symbol table="Arrows" row="" id="lftarrowlong" description=""/>
        <symbol table="Arrows" row="" id="downarrow" description=""/>
        <symbol table="Arrows" row="" id="downdoublearrow" description=""/>
        <symbol table="Arrows" row="" id="downimplies" description=""/>
        <symbol table="Arrows" row="" id="downleftarrow" description=""/>
        <symbol table="Arrows" row="" id="downrightarrow" description=""/>
        <symbol table="B" row="" id="cBbar" description=""/>
        <symbol table="B" row="" id="basis" description=""/>
        <symbol table="B" row="" id="basissm" description=""/>
        <symbol table="B" row="" id="calBsm" description=""/>
        <symbol table="B" row="" id="circleBsm" description=""/>
        <symbol table="Miscellaneous" row="130" id="bdot" description=""/>
        <symbol table="B" row="140" id="bdbldot" description=""/>
        <symbol table="B" row="150" id="Btilde" description=""/>
        <symbol table="B" row="160" id="Bhat" description=""/>
        <symbol table="B" row="160" id="bhat" description=""/>
        <symbol table="B" row="170" id="Bhatbold" description=""/>
        <symbol table="B" row="170" id="bhatbold" description=""/>
        <symbol table="B" row="180" id="Bhatitalic" description=""/>
        <symbol table="B" row="180" id="bhatitalic" description=""/>
        <symbol table="B" row="190" id="Bhatbolditalic" description=""/>
        <symbol table="B" row="190" id="bhatbolditalic" description=""/>
        <symbol table="B" row="200" id="Bbar" description=""/>
        <symbol table="B" row="200" id="bbar" description=""/>
        <symbol table="B" row="210" id="Bbarbold" description=""/>
        <symbol table="B" row="210" id="bbarbold" description=""/>
        <symbol table="B" row="220" id="Bbaritalic" description=""/>
        <symbol table="B" row="220" id="bbaritalic" description=""/>
        <symbol table="B" row="230" id="Bbarbolditalic" description=""/>
        <symbol table="B" row="230" id="bbarbolditalic" description=""/>
        <symbol table="B" row="250" id="Barrow" description=""/>
        <symbol table="B" row="260" id="Barrowbold" description=""/>
        <symbol table="B" row="260" id="barrowbold" description=""/>
        <symbol table="B" row="261" id="vecBbold" description=""/>
        <symbol table="B" row="261" id="vecbbold" description=""/>
        <symbol table="B" row="270" id="Barrowitalic" description=""/>
        <symbol table="B" row="270" id="barrowitalic" description=""/>
        <symbol table="B" row="280" id="Barrowbolditalic" description=""/>
        <symbol table="B" row="280" id="barrowbolditalic" description=""/>
        <symbol table="B" row="290" id="Bvec" description=""/>
        <symbol table="B" row="290" id="bvec" description=""/>
        <symbol table="B" row="300" id="Bvecbold" description=""/>
        <symbol table="B" row="300" id="bvecbold" description=""/>
        <symbol table="B" row="310" id="Bvecitalic" description=""/>
        <symbol table="B" row="310" id="bvecitalic" description=""/>
        <symbol table="B" row="320" id="Bvecbolditalic" description=""/>
        <symbol table="B" row="320" id="bvecbolditalic" description=""/>
        <symbol table="B" row="335" id="calB" description=""/>
        <symbol table="B" row="340" id="circleB" description=""/>
        <symbol table="Beta" row="100" id="Beta" description=""/>
        <symbol table="Beta" row="100" id="Beta2" description=""/>
        <symbol table="Beta" row="100" id="Betabar" description=""/>
        <symbol table="Beta" row="100" id="Betadbldot" description=""/>
        <symbol table="Beta" row="100" id="Betadot" description=""/>
        <symbol table="Beta" row="100" id="Betahat" description=""/>
        <symbol table="Beta" row="100" id="Betavec" description=""/>
        <symbol table="Beta" row="100" id="beta" description=""/>
        <symbol table="Beta" row="100" id="beta2" description=""/>
        <symbol table="Beta" row="100" id="betabar" description=""/>
        <symbol table="Beta" row="100" id="betadbldot" description=""/>
        <symbol table="Beta" row="100" id="betadot" description=""/>
        <symbol table="Beta" row="100" id="betahat" description=""/>
        <symbol table="Beta" row="100" id="betaminus" description=""/>
        <symbol table="Beta" row="100" id="betaplus" description=""/>
        <symbol table="Beta" row="100" id="betavec" description=""/>
        <symbol table="C" row="" id="Ccedil" description=""/>
        <symbol table="C" row="" id="basisC" description=""/>
        <symbol table="C" row="" id="calCsm" description=""/>
        <symbol table="C" row="" id="ccedil" description=""/>
        <symbol table="C" row="" id="circleCsm" description=""/>
        <symbol table="C" row="" id="doubleC" description=""/>
        <symbol table="C" row="150" id="Ctilde" description=""/>
        <symbol table="C" row="160" id="Chat" description=""/>
        <symbol table="C" row="160" id="chat" description=""/>
        <symbol table="C" row="170" id="Chatbold" description=""/>
        <symbol table="C" row="170" id="chatbold" description=""/>
        <symbol table="C" row="180" id="Chatitalic" description=""/>
        <symbol table="C" row="180" id="chatitalic" description=""/>
        <symbol table="C" row="190" id="Chatbolditalic" description=""/>
        <symbol table="C" row="190" id="chatbolditalic" description=""/>
        <symbol table="C" row="200" id="Cbar" description=""/>
        <symbol table="C" row="200" id="cbar" description=""/>
        <symbol table="C" row="210" id="Cbarbold" description=""/>
        <symbol table="C" row="210" id="cbarbold" description=""/>
        <symbol table="C" row="220" id="Cbaritalic" description=""/>
        <symbol table="C" row="220" id="cbaritalic" description=""/>
        <symbol table="C" row="230" id="Cbarbolditalic" description=""/>
        <symbol table="C" row="230" id="cbarbolditalic" description=""/>
        <symbol table="C" row="250" id="Carrow" description=""/>
        <symbol table="C" row="250" id="carrow" description=""/>
        <symbol table="C" row="260" id="Carrowbold" description=""/>
        <symbol table="C" row="260" id="carrowbold" description=""/>
        <symbol table="C" row="261" id="vecCbold" description=""/>
        <symbol table="C" row="261" id="veccbold" description=""/>
        <symbol table="C" row="270" id="Carrowitalic" description=""/>
        <symbol table="C" row="270" id="carrowitalic" description=""/>
        <symbol table="C" row="280" id="Carrowbolditalic" description=""/>
        <symbol table="C" row="280" id="carrowbolditalic" description=""/>
        <symbol table="C" row="290" id="Cvec" description=""/>
        <symbol table="C" row="290" id="cvec" description=""/>
        <symbol table="C" row="300" id="Cvecbold" description=""/>
        <symbol table="C" row="300" id="cvecbold" description=""/>
        <symbol table="C" row="310" id="Cvecitalic" description=""/>
        <symbol table="C" row="310" id="cvecitalic" description=""/>
        <symbol table="C" row="320" id="Cvecbolditalic" description=""/>
        <symbol table="C" row="320" id="cvecbolditalic" description=""/>
        <symbol table="C" row="330" id="scriptC" description=""/>
        <symbol table="C" row="335" id="calC" description=""/>
        <symbol table="C" row="340" id="circleC" description=""/>
        <symbol table="Chemistry" row="" id="revrxarrow" description=""/>
        <symbol table="Chemistry" row="" id="revrxarrow1" description=""/>
        <symbol table="Chemistry" row="" id="revrxarrow2" description=""/>
        <symbol table="Chemistry" row="" id="revrxarrowH20" description=""/>
        <symbol table="Chemistry" row="" id="revrxarrowhv" description=""/>
        <symbol table="Chemistry" row="" id="revrxarrowred" description=""/>
        <symbol table="Chemistry" row="" id="revrxnarrowk" description=""/>
        <symbol table="Chemistry" row="" id="revrxnarrowkco" description=""/>
        <symbol table="Chemistry" row="" id="revrxnarrowko2" description=""/>
        <symbol table="Chemistry" row="" id="revrxnk1" description=""/>
        <symbol table="Chemistry" row="" id="revrxnk2" description=""/>
        <symbol table="Chemistry" row="" id="revrxnkf" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowAcid" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowAcidic" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowBacteria" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowBase" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowBasic" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowClcat" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowDelta" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowEc" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowH20" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowHeat" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowNOcat" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowac" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowacidic" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowalpha" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowbeta" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowcatalyst" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowelec" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowelecap" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowelect" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowheatpressure" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowhex" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowhotCuOs" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowhv" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowk" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowk1" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowk2" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowk3" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowk4" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowlight" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowox" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowpt825" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowradeng" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowsf" description=""/>
        <symbol table="Chemistry" row="" id="rtarrowyeast" description=""/>
        <symbol table="Chemistry" row="" id="singlebond" description=""/>
        <symbol table="Chemistry" row="" id="wedgearrow" description=""/>
        <symbol table="Chemistry" row="" id="H2Ortarrow" description=""/>
        <symbol table="Chemistry" row="" id="alphaparticle" description=""/>
        <symbol table="Chemistry" row="" id="aromaticbond" description=""/>
        <symbol table="Chemistry" row="" id="aromaticbondshort" description=""/>
        <symbol table="Chemistry" row="" id="coldrtarrow" description=""/>
        <symbol table="Chemistry" row="" id="decrtarrow" description=""/>
        <symbol table="Chemistry" row="" id="electron" description=""/>
        <symbol table="Chemistry" row="" id="emf" description=""/>
        <symbol table="Chemistry" row="" id="energyarrowlong" description=""/>
        <symbol table="Chemistry" row="" id="energyarrowshort" description=""/>
        <symbol table="Chemistry" row="" id="energyarrowsmall" description=""/>
        <symbol table="Chemistry" row="" id="forces" description=""/>
        <symbol table="Chemistry" row="" id="hbar2" description=""/>
        <symbol table="Chemistry" row="" id="hbarred" description=""/>
        <symbol table="Chemistry" row="" id="increment" description=""/>
        <symbol table="Chemistry" row="" id="neutron" description=""/>
        <symbol table="Chemistry" row="" id="nuclearparticles" description=""/>
        <symbol table="Chemistry" row="" id="planck" description=""/>
        <symbol table="Chemistry" row="" id="planckbar" description=""/>
        <symbol table="Chemistry" row="" id="positron" description=""/>
        <symbol table="Chemistry" row="" id="proton" description=""/>
        <symbol table="Chemistry" row="" id="ptrtarrow" description=""/>
        <symbol table="Chemistry" row="" id="doublebond" description=""/>
        <symbol table="Chemistry" row="" id="lewisdot" description=""/>
        <symbol table="Chemistry" row="" id="triplebond" description=""/>
        <symbol table="Chi" row="100" id="Chi" description=""/>
        <symbol table="Chi" row="100" id="Chi2" description=""/>
        <symbol table="Chi" row="100" id="Chibar" description=""/>
        <symbol table="Chi" row="100" id="Chidbldot" description=""/>
        <symbol table="Chi" row="100" id="Chidot" description=""/>
        <symbol table="Chi" row="100" id="Chihat" description=""/>
        <symbol table="Chi" row="100" id="Chivec" description=""/>
        <symbol table="Chi" row="100" id="chi" description=""/>
        <symbol table="Chi" row="100" id="chi2" description=""/>
        <symbol table="Chi" row="100" id="chibar" description=""/>
        <symbol table="Chi" row="100" id="chidbldot" description=""/>
        <symbol table="Chi" row="100" id="chidot" description=""/>
        <symbol table="Chi" row="100" id="chihat" description=""/>
        <symbol table="Chi" row="100" id="chivec" description=""/>
        <symbol table="D" row="" id="basisD" description=""/>
        <symbol table="D" row="" id="calDsm" description=""/>
        <symbol table="D" row="160" id="Dhat" description=""/>
        <symbol table="D" row="160" id="dhat" description=""/>
        <symbol table="D" row="170" id="Dhatbold" description=""/>
        <symbol table="D" row="170" id="dhatbold" description=""/>
        <symbol table="D" row="180" id="Dhatitalic" description=""/>
        <symbol table="D" row="180" id="dhatitalic" description=""/>
        <symbol table="D" row="190" id="Dhatbolditalic" description=""/>
        <symbol table="D" row="190" id="dhatbolditalic" description=""/>
        <symbol table="D" row="200" id="Dbar" description=""/>
        <symbol table="D" row="200" id="dbar" description=""/>
        <symbol table="D" row="210" id="Dbarbold" description=""/>
        <symbol table="D" row="210" id="dbarbold" description=""/>
        <symbol table="D" row="220" id="Dbaritalic" description=""/>
        <symbol table="D" row="220" id="dbaritalic" description=""/>
        <symbol table="D" row="230" id="Dbarbolditalic" description=""/>
        <symbol table="D" row="230" id="dbarbolditalic" description=""/>
        <symbol table="D" row="250" id="Darrow" description=""/>
        <symbol table="D" row="250" id="darrow" description=""/>
        <symbol table="D" row="260" id="Darrowbold" description=""/>
        <symbol table="D" row="260" id="darrowbold" description=""/>
        <symbol table="D" row="261" id="vecDbold" description=""/>
        <symbol table="D" row="261" id="vecdbold" description=""/>
        <symbol table="D" row="270" id="Darrowitalic" description=""/>
        <symbol table="D" row="270" id="darrowitalic" description=""/>
        <symbol table="D" row="280" id="Darrowbolditalic" description=""/>
        <symbol table="D" row="280" id="darrowbolditalic" description=""/>
        <symbol table="D" row="290" id="Dvec" description=""/>
        <symbol table="D" row="290" id="dvec" description=""/>
        <symbol table="D" row="300" id="Dvecbold" description=""/>
        <symbol table="D" row="300" id="dvecbold" description=""/>
        <symbol table="D" row="310" id="Dvecitalic" description=""/>
        <symbol table="D" row="310" id="dvecitalic" description=""/>
        <symbol table="D" row="320" id="Dvecbolditalic" description=""/>
        <symbol table="D" row="320" id="dvecbolditalic" description=""/>
        <symbol table="D" row="330" id="scriptD" description=""/>
        <symbol table="D" row="335" id="calD" description=""/>
        <symbol table="D" row="340" id="circleD" description=""/>
        <symbol table="Delta" row="100" id="Delta" description=""/>
        <symbol table="Delta" row="100" id="Delta2" description=""/>
        <symbol table="Delta" row="100" id="Deltabar" description=""/>
        <symbol table="Delta" row="100" id="Deltadbldot" description=""/>
        <symbol table="Delta" row="100" id="Deltadot" description=""/>
        <symbol table="Delta" row="100" id="Deltahat" description=""/>
        <symbol table="Delta" row="100" id="Deltavec" description=""/>
        <symbol table="Delta" row="100" id="delta" description=""/>
        <symbol table="Delta" row="100" id="delta2" description=""/>
        <symbol table="Delta" row="100" id="deltabar" description=""/>
        <symbol table="Delta" row="100" id="deltadbldot" description=""/>
        <symbol table="Delta" row="100" id="deltadot" description=""/>
        <symbol table="Delta" row="100" id="deltahat" description=""/>
        <symbol table="Delta" row="100" id="deltavec" description=""/>
        <symbol table="E" row="" id="Ecirc" description=""/>
        <symbol table="E" row="" id="ecirc" description=""/>
        <symbol table="E" row="100" id="Eacute" description=""/>
        <symbol table="E" row="100" id="eacute" description=""/>
        <symbol table="E" row="110" id="Egrave" description=""/>
        <symbol table="E" row="110" id="egrave" description=""/>
        <symbol table="E" row="120" id="Euml" description=""/>
        <symbol table="E" row="120" id="euml" description=""/>
        <symbol table="E" row="160" id="Ehat" description=""/>
        <symbol table="E" row="160" id="ehat" description=""/>
        <symbol table="E" row="170" id="Ehatbold" description=""/>
        <symbol table="E" row="170" id="ehatbold" description=""/>
        <symbol table="E" row="180" id="Ehatitalic" description=""/>
        <symbol table="E" row="180" id="ehatitalic" description=""/>
        <symbol table="E" row="190" id="Ehatbolditalic" description=""/>
        <symbol table="E" row="190" id="ehatbolditalic" description=""/>
        <symbol table="E" row="200" id="Ebar" description=""/>
        <symbol table="E" row="200" id="ebar" description=""/>
        <symbol table="E" row="210" id="Ebarbold" description=""/>
        <symbol table="E" row="210" id="ebarbold" description=""/>
        <symbol table="E" row="220" id="Ebaritalic" description=""/>
        <symbol table="E" row="220" id="ebaritalic" description=""/>
        <symbol table="E" row="230" id="Ebarbolditalic" description=""/>
        <symbol table="E" row="230" id="ebarbolditalic" description=""/>
        <symbol table="E" row="250" id="Earrow" description=""/>
        <symbol table="E" row="250" id="earrow" description=""/>
        <symbol table="E" row="260" id="Earrowbold" description=""/>
        <symbol table="E" row="260" id="earrowbold" description=""/>
        <symbol table="E" row="261" id="vecEbold" description=""/>
        <symbol table="E" row="261" id="vecebold" description=""/>
        <symbol table="E" row="270" id="Earrowitalic" description=""/>
        <symbol table="E" row="270" id="earrowitalic" description=""/>
        <symbol table="E" row="280" id="Earrowbolditalic" description=""/>
        <symbol table="E" row="280" id="earrowbolditalic" description=""/>
        <symbol table="E" row="290" id="Evec" description=""/>
        <symbol table="E" row="290" id="evec" description=""/>
        <symbol table="E" row="300" id="Evecbold" description=""/>
        <symbol table="E" row="300" id="evecbold" description=""/>
        <symbol table="E" row="310" id="Evecitalic" description=""/>
        <symbol table="E" row="310" id="evecitalic" description=""/>
        <symbol table="E" row="320" id="Evecbolditalic" description=""/>
        <symbol table="E" row="320" id="evecbolditalic" description=""/>
        <symbol table="E" row="330" id="scriptE" description=""/>
        <symbol table="E" row="330" id="scripte" description=""/>
        <symbol table="E" row="340" id="circleE" description=""/>
        <symbol table="Ellipses" row="" id="hellipsis" description=""/>
        <symbol table="Ellipses" row="" id="hellipsis_acc" description=""/>
        <symbol table="Ellipses" row="" id="rellipsis" description=""/>
        <symbol table="Ellipses" row="" id="vellipsis" description=""/>
        <symbol table="Ellipses" row="" id="lellipsis" description=""/>
        <symbol table="Ellipses" row="" id="mellipsis" description=""/>
        <symbol table="Epsilon" row="100" id="Epsilon" description=""/>
        <symbol table="Epsilon" row="100" id="Epsilon2" description=""/>
        <symbol table="Epsilon" row="100" id="Epsilonbar" description=""/>
        <symbol table="Epsilon" row="100" id="Epsilondbldot" description=""/>
        <symbol table="Epsilon" row="100" id="Epsilondot" description=""/>
        <symbol table="Epsilon" row="100" id="Epsilonhat" description=""/>
        <symbol table="Epsilon" row="100" id="Epsilonvec" description=""/>
        <symbol table="Epsilon" row="100" id="epsilon" description=""/>
        <symbol table="Epsilon" row="100" id="epsilon2" description=""/>
        <symbol table="Epsilon" row="100" id="epsilon3" description=""/>
        <symbol table="Epsilon" row="100" id="epsilon_acc" description=""/>
        <symbol table="Epsilon" row="100" id="epsilonbar" description=""/>
        <symbol table="Epsilon" row="100" id="epsilondbldot" description=""/>
        <symbol table="Epsilon" row="100" id="epsilondot" description=""/>
        <symbol table="Epsilon" row="100" id="epsilonhat" description=""/>
        <symbol table="Epsilon" row="100" id="epsilontilde" description=""/>
        <symbol table="Epsilon" row="100" id="epsilonvec" description=""/>
        <symbol table="Eta" row="100" id="Eta" description=""/>
        <symbol table="Eta" row="100" id="Eta2" description=""/>
        <symbol table="Eta" row="100" id="Etabar" description=""/>
        <symbol table="Eta" row="100" id="Etadbldot" description=""/>
        <symbol table="Eta" row="100" id="Etadot" description=""/>
        <symbol table="Eta" row="100" id="Etahat" description=""/>
        <symbol table="Eta" row="100" id="Etavec" description=""/>
        <symbol table="Eta" row="100" id="eta" description=""/>
        <symbol table="Eta" row="100" id="eta2" description=""/>
        <symbol table="Eta" row="100" id="etabar" description=""/>
        <symbol table="Eta" row="100" id="etadbldot" description=""/>
        <symbol table="Eta" row="100" id="etadot" description=""/>
        <symbol table="Eta" row="100" id="etahat" description=""/>
        <symbol table="Eta" row="100" id="etavec" description=""/>
        <symbol table="F" row="160" id="Fhat" description=""/>
        <symbol table="F" row="160" id="fhat" description=""/>
        <symbol table="F" row="170" id="Fhatbold" description=""/>
        <symbol table="F" row="170" id="fhatbold" description=""/>
        <symbol table="F" row="180" id="Fhatitalic" description=""/>
        <symbol table="F" row="180" id="fhatitalic" description=""/>
        <symbol table="F" row="190" id="Fhatbolditalic" description=""/>
        <symbol table="F" row="190" id="fhatbolditalic" description=""/>
        <symbol table="F" row="200" id="Fbar" description=""/>
        <symbol table="F" row="200" id="fbar" description=""/>
        <symbol table="F" row="210" id="Fbarbold" description=""/>
        <symbol table="F" row="210" id="fbarbold" description=""/>
        <symbol table="F" row="220" id="Fbaritalic" description=""/>
        <symbol table="F" row="220" id="fbaritalic" description=""/>
        <symbol table="F" row="230" id="Fbarbolditalic" description=""/>
        <symbol table="F" row="230" id="fbarbolditalic" description=""/>
        <symbol table="F" row="250" id="Farrow" description=""/>
        <symbol table="F" row="250" id="farrow" description=""/>
        <symbol table="F" row="260" id="Farrowbold" description=""/>
        <symbol table="F" row="260" id="farrowbold" description=""/>
        <symbol table="F" row="261" id="vecFbold" description=""/>
        <symbol table="F" row="261" id="vecfbold" description=""/>
        <symbol table="F" row="270" id="Farrowitalic" description=""/>
        <symbol table="F" row="270" id="farrowitalic" description=""/>
        <symbol table="F" row="280" id="Farrowbolditalic" description=""/>
        <symbol table="F" row="280" id="farrowbolditalic" description=""/>
        <symbol table="F" row="290" id="Fvec" description=""/>
        <symbol table="F" row="290" id="fvec" description=""/>
        <symbol table="F" row="300" id="Fvecbold" description=""/>
        <symbol table="F" row="300" id="fvecbold" description=""/>
        <symbol table="F" row="310" id="Fvecitalic" description=""/>
        <symbol table="F" row="310" id="fvecitalic" description=""/>
        <symbol table="F" row="320" id="Fvecbolditalic" description=""/>
        <symbol table="F" row="320" id="fvecbolditalic" description=""/>
        <symbol table="F" row="330" id="scriptF" description=""/>
        <symbol table="F" row="340" id="circleF" description=""/>
        <symbol table="G" row="" id="calG_tilde" description=""/>
        <symbol table="G" row="" id="calGsm" description=""/>
        <symbol table="G" row="" id="calGsm_tilde" description=""/>
        <symbol table="G" row="160" id="Ghat" description=""/>
        <symbol table="G" row="160" id="ghat" description=""/>
        <symbol table="G" row="170" id="Ghatbold" description=""/>
        <symbol table="G" row="170" id="ghatbold" description=""/>
        <symbol table="G" row="180" id="Ghatitalic" description=""/>
        <symbol table="G" row="180" id="ghatitalic" description=""/>
        <symbol table="G" row="190" id="Ghatbolditalic" description=""/>
        <symbol table="G" row="190" id="ghatbolditalic" description=""/>
        <symbol table="G" row="200" id="Gbar" description=""/>
        <symbol table="G" row="200" id="gbar" description=""/>
        <symbol table="G" row="210" id="Gbarbold" description=""/>
        <symbol table="G" row="210" id="gbarbold" description=""/>
        <symbol table="G" row="220" id="Gbaritalic" description=""/>
        <symbol table="G" row="220" id="gbaritalic" description=""/>
        <symbol table="G" row="230" id="Gbarbolditalic" description=""/>
        <symbol table="G" row="230" id="gbarbolditalic" description=""/>
        <symbol table="G" row="250" id="Garrow" description=""/>
        <symbol table="G" row="250" id="garrow" description=""/>
        <symbol table="G" row="260" id="Garrowbold" description=""/>
        <symbol table="G" row="260" id="garrowbold" description=""/>
        <symbol table="G" row="261" id="vecGbold" description=""/>
        <symbol table="G" row="261" id="vecgbold" description=""/>
        <symbol table="G" row="270" id="Garrowitalic" description=""/>
        <symbol table="G" row="270" id="garrowitalic" description=""/>
        <symbol table="G" row="280" id="Garrowbolditalic" description=""/>
        <symbol table="G" row="280" id="garrowbolditalic" description=""/>
        <symbol table="G" row="290" id="Gvec" description=""/>
        <symbol table="G" row="290" id="gvec" description=""/>
        <symbol table="G" row="300" id="Gvecbold" description=""/>
        <symbol table="G" row="300" id="gvecbold" description=""/>
        <symbol table="G" row="310" id="Gvecitalic" description=""/>
        <symbol table="G" row="310" id="gvecitalic" description=""/>
        <symbol table="G" row="320" id="Gvecbolditalic" description=""/>
        <symbol table="G" row="320" id="gvecbolditalic" description=""/>
        <symbol table="G" row="335" id="calG" description=""/>
        <symbol table="G" row="340" id="circleG" description=""/>
        <symbol table="Gamma" row="100" id="Gamma" description=""/>
        <symbol table="Gamma" row="100" id="Gamma2" description=""/>
        <symbol table="Gamma" row="100" id="Gamma_acc" description=""/>
        <symbol table="Gamma" row="100" id="Gammabar" description=""/>
        <symbol table="Gamma" row="100" id="Gammadbldot" description=""/>
        <symbol table="Gamma" row="100" id="Gammadot" description=""/>
        <symbol table="Gamma" row="100" id="Gammahat" description=""/>
        <symbol table="Gamma" row="100" id="Gammavec" description=""/>
        <symbol table="Gamma" row="100" id="gamma" description=""/>
        <symbol table="Gamma" row="100" id="gamma2" description=""/>
        <symbol table="Gamma" row="100" id="gammabar" description=""/>
        <symbol table="Gamma" row="100" id="gammadbldot" description=""/>
        <symbol table="Gamma" row="100" id="gammadot" description=""/>
        <symbol table="Gamma" row="100" id="gammahat" description=""/>
        <symbol table="Gamma" row="100" id="gammavec" description=""/>
        <symbol table="Greek" row="" id="redOmega" description=""/>
        <symbol table="Greek" row="" id="red_pi" description=""/>
        <symbol table="Greek" row="" id="greenOmega" description=""/>
        <symbol table="H" row="" id="bbH" description=""/>
        <symbol table="H" row="" id="doubleH" description=""/>
        <symbol table="H" row="160" id="Hhat" description=""/>
        <symbol table="H" row="160" id="hhat" description=""/>
        <symbol table="H" row="170" id="Hhatbold" description=""/>
        <symbol table="H" row="170" id="hhatbold" description=""/>
        <symbol table="H" row="180" id="Hhatitalic" description=""/>
        <symbol table="H" row="180" id="hhatitalic" description=""/>
        <symbol table="H" row="190" id="Hhatbolditalic" description=""/>
        <symbol table="H" row="190" id="hhatbolditalic" description=""/>
        <symbol table="H" row="200" id="Hbar" description=""/>
        <symbol table="H" row="200" id="hbar" description=""/>
        <symbol table="H" row="210" id="Hbarbold" description=""/>
        <symbol table="H" row="210" id="hbarbold" description=""/>
        <symbol table="H" row="220" id="Hbaritalic" description=""/>
        <symbol table="H" row="220" id="hbaritalic" description=""/>
        <symbol table="H" row="230" id="Hbarbolditalic" description=""/>
        <symbol table="H" row="230" id="hbarbolditalic" description=""/>
        <symbol table="H" row="250" id="Harrow" description=""/>
        <symbol table="H" row="250" id="harrow" description=""/>
        <symbol table="H" row="260" id="Harrowbold" description=""/>
        <symbol table="H" row="260" id="harrowbold" description=""/>
        <symbol table="H" row="261" id="vecHbold" description=""/>
        <symbol table="H" row="261" id="vechbold" description=""/>
        <symbol table="H" row="270" id="Harrowitalic" description=""/>
        <symbol table="H" row="270" id="harrowitalic" description=""/>
        <symbol table="H" row="280" id="Harrowbolditalic" description=""/>
        <symbol table="H" row="280" id="harrowbolditalic" description=""/>
        <symbol table="H" row="290" id="Hvec" description=""/>
        <symbol table="H" row="290" id="hvec" description=""/>
        <symbol table="H" row="300" id="Hvecbold" description=""/>
        <symbol table="H" row="300" id="hvecbold" description=""/>
        <symbol table="H" row="310" id="Hvecitalic" description=""/>
        <symbol table="H" row="310" id="hvecitalic" description=""/>
        <symbol table="H" row="320" id="Hvecbolditalic" description=""/>
        <symbol table="H" row="320" id="hvecbolditalic" description=""/>
        <symbol table="H" row="335" id="calH" description=""/>
        <symbol table="H" row="340" id="circleH" description=""/>
        <symbol table="Hebrew" row="" id="bet" description=""/>
        <symbol table="Hebrew" row="" id="aleph" description=""/>
        <symbol table="Hebrew" row="" id="dalet" description=""/>
        <symbol table="Hebrew" row="" id="eth" description=""/>
        <symbol table="Hebrew" row="" id="gimel" description=""/>
        <symbol table="I" row="" id="Icirc" description=""/>
        <symbol table="I" row="" id="icirc" description=""/>
        <symbol table="I" row="" id="ihatboldred" description=""/>
        <symbol table="I" row="90" id="ibold" description=""/>
        <symbol table="I" row="100" id="Iacute" description=""/>
        <symbol table="I" row="100" id="iacute" description=""/>
        <symbol table="I" row="110" id="Igrave" description=""/>
        <symbol table="I" row="110" id="igrave" description=""/>
        <symbol table="I" row="120" id="Iuml" description=""/>
        <symbol table="I" row="120" id="iuml" description=""/>
        <symbol table="I" row="160" id="Ihat" description=""/>
        <symbol table="I" row="160" id="ihat" description=""/>
        <symbol table="I" row="170" id="Ihatbold" description=""/>
        <symbol table="I" row="170" id="ihatbold" description=""/>
        <symbol table="I" row="180" id="Ihatitalic" description=""/>
        <symbol table="I" row="180" id="ihatitalic" description=""/>
        <symbol table="I" row="185" id="ihatitalicred" description=""/>
        <symbol table="I" row="190" id="Ihatbolditalic" description=""/>
        <symbol table="I" row="190" id="ihatbolditalic" description=""/>
        <symbol table="I" row="195" id="ihatbolditalicred" description=""/>
        <symbol table="I" row="200" id="Ibar" description=""/>
        <symbol table="I" row="200" id="ibar" description=""/>
        <symbol table="I" row="210" id="Ibarbold" description=""/>
        <symbol table="I" row="220" id="Ibaritalic" description=""/>
        <symbol table="I" row="220" id="ibaritalic" description=""/>
        <symbol table="I" row="230" id="Ibarbolditalic" description=""/>
        <symbol table="I" row="250" id="Iarrow" description=""/>
        <symbol table="I" row="250" id="iarrow" description=""/>
        <symbol table="I" row="260" id="Iarrowbold" description=""/>
        <symbol table="I" row="260" id="iarrowbold" description=""/>
        <symbol table="I" row="261" id="vecIbold" description=""/>
        <symbol table="I" row="261" id="vecibold" description=""/>
        <symbol table="I" row="270" id="Iarrowitalic" description=""/>
        <symbol table="I" row="270" id="iarrowitalic" description=""/>
        <symbol table="I" row="280" id="Iarrowbolditalic" description=""/>
        <symbol table="I" row="280" id="iarrowbolditalic" description=""/>
        <symbol table="I" row="290" id="Ivec" description=""/>
        <symbol table="I" row="290" id="ivec" description=""/>
        <symbol table="I" row="300" id="Ivecbold" description=""/>
        <symbol table="I" row="300" id="ivecbold" description=""/>
        <symbol table="I" row="310" id="Ivecitalic" description=""/>
        <symbol table="I" row="310" id="ivecitalic" description=""/>
        <symbol table="I" row="320" id="Ivecbolditalic" description=""/>
        <symbol table="I" row="320" id="ivecbolditalic" description=""/>
        <symbol table="I" row="340" id="circleI" description=""/>
        <symbol table="Iota" row="100" id="Iota" description=""/>
        <symbol table="Iota" row="100" id="Iota2" description=""/>
        <symbol table="Iota" row="100" id="Iotabar" description=""/>
        <symbol table="Iota" row="100" id="Iotadbldot" description=""/>
        <symbol table="Iota" row="100" id="Iotadot" description=""/>
        <symbol table="Iota" row="100" id="Iotahat" description=""/>
        <symbol table="Iota" row="100" id="Iotavec" description=""/>
        <symbol table="Iota" row="100" id="iota" description=""/>
        <symbol table="Iota" row="100" id="iota2" description=""/>
        <symbol table="Iota" row="100" id="iotabar" description=""/>
        <symbol table="Iota" row="100" id="iotadbldot" description=""/>
        <symbol table="Iota" row="100" id="iotadot" description=""/>
        <symbol table="Iota" row="100" id="iotahat" description=""/>
        <symbol table="Iota" row="100" id="iotavec" description=""/>
        <symbol table="J" row="" id="jhatboldred" description=""/>
        <symbol table="J" row="90" id="jbold" description=""/>
        <symbol table="J" row="160" id="Jhat" description=""/>
        <symbol table="J" row="160" id="jhat" description=""/>
        <symbol table="J" row="170" id="Jhatbold" description=""/>
        <symbol table="J" row="170" id="jhatbold" description=""/>
        <symbol table="J" row="180" id="Jhatitalic" description=""/>
        <symbol table="J" row="180" id="jhatitalic" description=""/>
        <symbol table="J" row="185" id="jhatitalicred" description=""/>
        <symbol table="J" row="190" id="Jhatbolditalic" description=""/>
        <symbol table="J" row="190" id="jhatbolditalic" description=""/>
        <symbol table="J" row="195" id="jhatbolditalicred" description=""/>
        <symbol table="J" row="200" id="Jbar" description=""/>
        <symbol table="J" row="200" id="jbar" description=""/>
        <symbol table="J" row="210" id="Jbarbold" description=""/>
        <symbol table="J" row="210" id="jbarbold" description=""/>
        <symbol table="J" row="220" id="Jbaritalic" description=""/>
        <symbol table="J" row="220" id="jbaritalic" description=""/>
        <symbol table="J" row="230" id="Jbarbolditalic" description=""/>
        <symbol table="J" row="230" id="jbarbolditalic" description=""/>
        <symbol table="J" row="250" id="Jarrow" description=""/>
        <symbol table="J" row="250" id="jarrow" description=""/>
        <symbol table="J" row="260" id="Jarrowbold" description=""/>
        <symbol table="J" row="260" id="jarrowbold" description=""/>
        <symbol table="J" row="261" id="vecJbold" description=""/>
        <symbol table="J" row="261" id="vecjbold" description=""/>
        <symbol table="J" row="270" id="Jarrowitalic" description=""/>
        <symbol table="J" row="270" id="jarrowitalic" description=""/>
        <symbol table="J" row="280" id="Jarrowbolditalic" description=""/>
        <symbol table="J" row="280" id="jarrowbolditalic" description=""/>
        <symbol table="J" row="290" id="Jvec" description=""/>
        <symbol table="J" row="290" id="jvec" description=""/>
        <symbol table="J" row="300" id="Jvecbold" description=""/>
        <symbol table="J" row="300" id="jvecbold" description=""/>
        <symbol table="J" row="310" id="Jvecitalic" description=""/>
        <symbol table="J" row="310" id="jvecitalic" description=""/>
        <symbol table="J" row="320" id="Jvecbolditalic" description=""/>
        <symbol table="J" row="320" id="jvecbolditalic" description=""/>
        <symbol table="J" row="340" id="circleJ" description=""/>
        <symbol table="K" row="90" id="kbold" description=""/>
        <symbol table="K" row="160" id="Khat" description=""/>
        <symbol table="K" row="160" id="khat" description=""/>
        <symbol table="K" row="170" id="Khatbold" description=""/>
        <symbol table="K" row="170" id="khatbold" description=""/>
        <symbol table="K" row="180" id="khatitalic" description=""/>
        <symbol table="K" row="185" id="khatitalicred" description=""/>
        <symbol table="K" row="190" id="Khatbolditalic" description=""/>
        <symbol table="K" row="190" id="khatbolditalic" description=""/>
        <symbol table="K" row="195" id="khatbolditalicred" description=""/>
        <symbol table="K" row="197" id="khatboldred" description=""/>
        <symbol table="K" row="200" id="Kbar" description=""/>
        <symbol table="K" row="200" id="kbar" description=""/>
        <symbol table="K" row="210" id="Kbarbold" description=""/>
        <symbol table="K" row="210" id="kbarbold" description=""/>
        <symbol table="K" row="220" id="Kbaritalic" description=""/>
        <symbol table="K" row="220" id="kbaritalic" description=""/>
        <symbol table="K" row="230" id="Kbarbolditalic" description=""/>
        <symbol table="K" row="230" id="kbarbolditalic" description=""/>
        <symbol table="K" row="250" id="Karrow" description=""/>
        <symbol table="K" row="250" id="karrow" description=""/>
        <symbol table="K" row="260" id="Karrowbold" description=""/>
        <symbol table="K" row="260" id="karrowbold" description=""/>
        <symbol table="K" row="261" id="vecKbold" description=""/>
        <symbol table="K" row="261" id="veckbold" description=""/>
        <symbol table="K" row="270" id="Karrowitalic" description=""/>
        <symbol table="K" row="270" id="karrowitalic" description=""/>
        <symbol table="K" row="280" id="Karrowbolditalic" description=""/>
        <symbol table="K" row="280" id="karrowbolditalic" description=""/>
        <symbol table="K" row="290" id="Kvec" description=""/>
        <symbol table="K" row="290" id="kvec" description=""/>
        <symbol table="K" row="300" id="Kvecbold" description=""/>
        <symbol table="K" row="300" id="kvecbold" description=""/>
        <symbol table="K" row="310" id="Kvecitalic" description=""/>
        <symbol table="K" row="310" id="kvecitalic" description=""/>
        <symbol table="K" row="320" id="Kvecbolditalic" description=""/>
        <symbol table="K" row="320" id="kvecbolditalic" description=""/>
        <symbol table="K" row="340" id="circleK" description=""/>
        <symbol table="Kappa" row="100" id="Kappa" description=""/>
        <symbol table="Kappa" row="100" id="Kappa2" description=""/>
        <symbol table="Kappa" row="100" id="Kappabar" description=""/>
        <symbol table="Kappa" row="100" id="Kappadbldot" description=""/>
        <symbol table="Kappa" row="100" id="Kappadot" description=""/>
        <symbol table="Kappa" row="100" id="Kappahat" description=""/>
        <symbol table="Kappa" row="100" id="Kappavec" description=""/>
        <symbol table="Kappa" row="100" id="kappa" description=""/>
        <symbol table="Kappa" row="100" id="kappa2" description=""/>
        <symbol table="Kappa" row="100" id="kappabar" description=""/>
        <symbol table="Kappa" row="100" id="kappadbldot" description=""/>
        <symbol table="Kappa" row="100" id="kappadot" description=""/>
        <symbol table="Kappa" row="100" id="kappahat" description=""/>
        <symbol table="Kappa" row="100" id="kappavec" description=""/>
        <symbol table="L" row="" id="scriptl_small" description=""/>
        <symbol table="L" row="130" id="ldot" description=""/>
        <symbol table="L" row="160" id="Lhat" description=""/>
        <symbol table="L" row="160" id="lhat" description=""/>
        <symbol table="L" row="170" id="Lhatbold" description=""/>
        <symbol table="L" row="170" id="lhatbold" description=""/>
        <symbol table="L" row="180" id="Lhatitalic" description=""/>
        <symbol table="L" row="180" id="lhatitalic" description=""/>
        <symbol table="L" row="190" id="Lhatbolditalic" description=""/>
        <symbol table="L" row="190" id="lhatbolditalic" description=""/>
        <symbol table="L" row="200" id="Lbar" description=""/>
        <symbol table="L" row="200" id="lbar" description=""/>
        <symbol table="L" row="210" id="Lbarbold" description=""/>
        <symbol table="L" row="210" id="lbarbold" description=""/>
        <symbol table="L" row="220" id="Lbaritalic" description=""/>
        <symbol table="L" row="220" id="lbaritalic" description=""/>
        <symbol table="L" row="230" id="Lbarbolditalic" description=""/>
        <symbol table="L" row="230" id="lbarbolditalic" description=""/>
        <symbol table="L" row="250" id="Larrow" description=""/>
        <symbol table="L" row="250" id="larrow" description=""/>
        <symbol table="L" row="260" id="Larrowbold" description=""/>
        <symbol table="L" row="260" id="larrowbold" description=""/>
        <symbol table="L" row="261" id="vecLbold" description=""/>
        <symbol table="L" row="261" id="veclbold" description=""/>
        <symbol table="L" row="270" id="Larrowitalic" description=""/>
        <symbol table="L" row="270" id="larrowitalic" description=""/>
        <symbol table="L" row="280" id="Larrowbolditalic" description=""/>
        <symbol table="L" row="280" id="larrowbolditalic" description=""/>
        <symbol table="L" row="290" id="Lvec" description=""/>
        <symbol table="L" row="290" id="lvec" description=""/>
        <symbol table="L" row="300" id="Lvecbold" description=""/>
        <symbol table="L" row="300" id="lvecbold" description=""/>
        <symbol table="L" row="310" id="Lvecitalic" description=""/>
        <symbol table="L" row="310" id="lvecitalic" description=""/>
        <symbol table="L" row="320" id="Lvecbolditalic" description=""/>
        <symbol table="L" row="320" id="lvecbolditalic" description=""/>
        <symbol table="L" row="330" id="scriptL" description=""/>
        <symbol table="L" row="330" id="scriptl" description=""/>
        <symbol table="L" row="340" id="circleL" description=""/>
        <symbol table="Lambda" row="100" id="Lambda" description=""/>
        <symbol table="Lambda" row="100" id="Lambda2" description=""/>
        <symbol table="Lambda" row="100" id="Lambdabar" description=""/>
        <symbol table="Lambda" row="100" id="Lambdadbldot" description=""/>
        <symbol table="Lambda" row="100" id="Lambdadot" description=""/>
        <symbol table="Lambda" row="100" id="Lambdahat" description=""/>
        <symbol table="Lambda" row="100" id="Lambdavec" description=""/>
        <symbol table="Lambda" row="100" id="lambda" description=""/>
        <symbol table="Lambda" row="100" id="lambda2" description=""/>
        <symbol table="Lambda" row="100" id="lambdabar" description=""/>
        <symbol table="Lambda" row="100" id="lambdadbldot" description=""/>
        <symbol table="Lambda" row="100" id="lambdadot" description=""/>
        <symbol table="Lambda" row="100" id="lambdahat" description=""/>
        <symbol table="Lambda" row="100" id="lambdahatsmall" description=""/>
        <symbol table="Lambda" row="100" id="lambdavec" description=""/>
        <symbol table="Lines" row="" id="bigbackslash" description=""/>
        <symbol table="Lines" row="" id="bigline" description=""/>
        <symbol table="Lines" row="" id="bigslash" description=""/>
        <symbol table="M" row="160" id="Mhat" description=""/>
        <symbol table="M" row="160" id="mhat" description=""/>
        <symbol table="M" row="170" id="Mhatbold" description=""/>
        <symbol table="M" row="170" id="mhatbold" description=""/>
        <symbol table="M" row="180" id="Mhatitalic" description=""/>
        <symbol table="M" row="180" id="mhatitalic" description=""/>
        <symbol table="M" row="190" id="Mhatbolditalic" description=""/>
        <symbol table="M" row="190" id="mhatbolditalic" description=""/>
        <symbol table="M" row="200" id="Mbar" description=""/>
        <symbol table="M" row="200" id="mbar" description=""/>
        <symbol table="M" row="210" id="Mbarbold" description=""/>
        <symbol table="M" row="210" id="mbarbold" description=""/>
        <symbol table="M" row="220" id="Mbaritalic" description=""/>
        <symbol table="M" row="220" id="mbaritalic" description=""/>
        <symbol table="M" row="230" id="Mbarbolditalic" description=""/>
        <symbol table="M" row="230" id="mbarbolditalic" description=""/>
        <symbol table="M" row="250" id="Marrow" description=""/>
        <symbol table="M" row="250" id="marrow" description=""/>
        <symbol table="M" row="260" id="Marrowbold" description=""/>
        <symbol table="M" row="260" id="marrowbold" description=""/>
        <symbol table="M" row="261" id="vecMbold" description=""/>
        <symbol table="M" row="261" id="vecmbold" description=""/>
        <symbol table="M" row="270" id="Marrowitalic" description=""/>
        <symbol table="M" row="270" id="marrowitalic" description=""/>
        <symbol table="M" row="280" id="Marrowbolditalic" description=""/>
        <symbol table="M" row="280" id="marrowbolditalic" description=""/>
        <symbol table="M" row="290" id="Mvec" description=""/>
        <symbol table="M" row="290" id="mvec" description=""/>
        <symbol table="M" row="300" id="Mvecbold" description=""/>
        <symbol table="M" row="300" id="mvecbold" description=""/>
        <symbol table="M" row="310" id="Mvecitalic" description=""/>
        <symbol table="M" row="310" id="mvecitalic" description=""/>
        <symbol table="M" row="320" id="Mvecbolditalic" description=""/>
        <symbol table="M" row="320" id="mvecbolditalic" description=""/>
        <symbol table="M" row="330" id="scriptM" description=""/>
        <symbol table="M" row="335" id="calM" description=""/>
        <symbol table="M" row="340" id="circleM" description=""/>
        <symbol table="Math" row="" id="almostequal" description=""/>
        <symbol table="Math" row="" id="almostequal_equal" description=""/>
        <symbol table="Math" row="" id="approximate" description=""/>
        <symbol table="Math" row="" id="bottomintegral" description=""/>
        <symbol table="Math" row="" id="rt_angle_arc" description=""/>
        <symbol table="Math" row="" id="Reals" description=""/>
        <symbol table="Math" row="" id="Reals2" description=""/>
        <symbol table="Math" row="" id="complex" description=""/>
        <symbol table="Math" row="" id="contains" description=""/>
        <symbol table="Math" row="" id="contourintegral" description=""/>
        <symbol table="Math" row="" id="cubic_root" description=""/>
        <symbol table="Math" row="" id="divslash" description=""/>
        <symbol table="Math" row="" id="doteq" description=""/>
        <symbol table="Math" row="" id="element" description=""/>
        <symbol table="Math" row="" id="end_proof" description=""/>
        <symbol table="Math" row="" id="exists" description=""/>
        <symbol table="Math" row="" id="forall" description=""/>
        <symbol table="Math" row="" id="fprimex_acc" description=""/>
        <symbol table="Math" row="" id="fracslash" description=""/>
        <symbol table="Math" row="" id="frasl" description=""/>
        <symbol table="Math" row="" id="fx_acc" description=""/>
        <symbol table="Math" row="" id="gprimex_acc" description=""/>
        <symbol table="Math" row="" id="greaterthan_rq" description=""/>
        <symbol table="Math" row="" id="gx_acc" description=""/>
        <symbol table="Math" row="" id="hprimex_acc" description=""/>
        <symbol table="Math" row="" id="hx_acc" description=""/>
        <symbol table="Math" row="" id="infin" description=""/>
        <symbol table="Math" row="" id="lessthan_lq" description=""/>
        <symbol table="Math" row="" id="nary_and" description=""/>
        <symbol table="Math" row="" id="nary_coproduct" description=""/>
        <symbol table="Math" row="" id="nary_intersect" description=""/>
        <symbol table="Math" row="" id="nary_or" description=""/>
        <symbol table="Math" row="" id="nary_product" description=""/>
        <symbol table="Math" row="" id="nary_summation" description=""/>
        <symbol table="Math" row="" id="nary_summation_acc" description=""/>
        <symbol table="Math" row="" id="nary_union" description=""/>
        <symbol table="Math" row="" id="neg" description=""/>
        <symbol table="Math" row="" id="neither_approx" description=""/>
        <symbol table="Math" row="" id="precedes" description=""/>
        <symbol table="Math" row="" id="precedes_equal" description=""/>
        <symbol table="Math" row="" id="precedes_equiv" description=""/>
        <symbol table="Math" row="" id="precedes_rel" description=""/>
        <symbol table="Math" row="" id="prime" description=""/>
        <symbol table="Math" row="" id="proportion" description=""/>
        <symbol table="Math" row="" id="propto" description=""/>
        <symbol table="Math" row="" id="redmultiply" description=""/>
        <symbol table="Math" row="" id="redplusminus" description=""/>
        <symbol table="Math" row="" id="equal_all" description=""/>
        <symbol table="Math" row="" id="equal_geom" description=""/>
        <symbol table="Math" row="" id="equal_greater" description=""/>
        <symbol table="Math" row="" id="equal_less" description=""/>
        <symbol table="Math" row="" id="equal_parallel" description=""/>
        <symbol table="Math" row="" id="equal_precedes" description=""/>
        <symbol table="Math" row="" id="equal_succeeds" description=""/>
        <symbol table="Math" row="" id="equals" description=""/>
        <symbol table="Math" row="" id="equiangular" description=""/>
        <symbol table="Math" row="" id="equilarrow" description=""/>
        <symbol table="Math" row="" id="equiv_geom" description=""/>
        <symbol table="Math" row="" id="equiv_strict" description=""/>
        <symbol table="Math" row="" id="equiv_to" description=""/>
        <symbol table="Math" row="" id="euler" description=""/>
        <symbol table="Math" row="" id="greenmultiply" description=""/>
        <symbol table="Math" row="" id="integers" description=""/>
        <symbol table="Math" row="" id="not" description=""/>
        <symbol table="Math" row="" id="not_almostequal" description=""/>
        <symbol table="Math" row="" id="not_approx" description=""/>
        <symbol table="Math" row="" id="not_asymptotic" description=""/>
        <symbol table="Math" row="" id="not_contains" description=""/>
        <symbol table="Math" row="" id="not_element" description=""/>
        <symbol table="Math" row="" id="not_exists" description=""/>
        <symbol table="Math" row="" id="not_forces" description=""/>
        <symbol table="Math" row="" id="not_greater" description=""/>
        <symbol table="Math" row="" id="not_identical" description=""/>
        <symbol table="Math" row="" id="not_less" description=""/>
        <symbol table="Math" row="" id="not_parallel" description=""/>
        <symbol table="Math" row="" id="not_precedes" description=""/>
        <symbol table="Math" row="" id="not_proves" description=""/>
        <symbol table="Math" row="" id="not_subset" description=""/>
        <symbol table="Math" row="" id="not_subset_neq" description=""/>
        <symbol table="Math" row="" id="not_succeeds" description=""/>
        <symbol table="Math" row="" id="not_superset" description=""/>
        <symbol table="Math" row="" id="not_supersetneq" description=""/>
        <symbol table="Math" row="" id="not_true" description=""/>
        <symbol table="Math" row="" id="notcongruent" description=""/>
        <symbol table="Math" row="" id="notdivides" description=""/>
        <symbol table="Math" row="" id="notequal" description=""/>
        <symbol table="Math" row="" id="notequiv" description=""/>
        <symbol table="Math" row="" id="notgreater" description=""/>
        <symbol table="Math" row="" id="notgreaterorequal" description=""/>
        <symbol table="Math" row="" id="notin" description=""/>
        <symbol table="Math" row="" id="notless" description=""/>
        <symbol table="Math" row="" id="notlessorequal" description=""/>
        <symbol table="Math" row="" id="notrelated" description=""/>
        <symbol table="Math" row="" id="notsubset" description=""/>
        <symbol table="Math" row="100" id="and" description=""/>
        <symbol table="Math" row="110" id="angle" description=""/>
        <symbol table="Math" row="120" id="approx" description=""/>
        <symbol table="Math" row="130" id="asymptotic" description=""/>
        <symbol table="Math" row="140" id="bigdiv" description=""/>
        <symbol table="Math" row="150" id="bra" description=""/>
        <symbol table="Math" row="160" id="circle1" description=""/>
        <symbol table="Math" row="170" id="circle2" description=""/>
        <symbol table="Math" row="180" id="circle3" description=""/>
        <symbol table="Math" row="190" id="circle4" description=""/>
        <symbol table="Math" row="200" id="circle5" description=""/>
        <symbol table="Math" row="210" id="circleminus" description=""/>
        <symbol table="Math" row="220" id="circleplus" description=""/>
        <symbol table="Math" row="230" id="circleequals" description=""/>
        <symbol table="Math" row="240" id="ckgreater" description=""/>
        <symbol table="Math" row="250" id="ckgreaterequal" description=""/>
        <symbol table="Math" row="260" id="ckless" description=""/>
        <symbol table="Math" row="270" id="cklessequal" description=""/>
        <symbol table="Math" row="280" id="ckequal" description=""/>
        <symbol table="Math" row="290" id="compose" description=""/>
        <symbol table="Math" row="300" id="congruent" description=""/>
        <symbol table="Math" row="310" id="cross" description=""/>
        <symbol table="Math" row="320" id="degree" description=""/>
        <symbol table="Math" row="330" id="divide" description=""/>
        <symbol table="Math" row="340" id="doubleint_r" description=""/>
        <symbol table="Math" row="345" id="doubleintegral" description=""/>
        <symbol table="Math" row="350" id="doublelineint" description=""/>
        <symbol table="Math" row="355" id="doubleprime" description=""/>
        <symbol table="Math" row="360" id="empty" description=""/>
        <symbol table="Math" row="370" id="empty_set" description=""/>
        <symbol table="Math" row="380" id="eqq" description=""/>
        <symbol table="Math" row="400" id="equivalent" description=""/>
        <symbol table="Math" row="410" id="greaterorequal" description=""/>
        <symbol table="Math" row="420" id="greaterthan" description=""/>
        <symbol table="Math" row="430" id="half" description=""/>
        <symbol table="Math" row="440" id="implies" description=""/>
        <symbol table="Math" row="450" id="infinity" description=""/>
        <symbol table="Math" row="460" id="infinity_acc" description=""/>
        <symbol table="Math" row="470" id="infinitysm" description=""/>
        <symbol table="Math" row="480" id="int" description=""/>
        <symbol table="Math" row="490" id="intbig" description=""/>
        <symbol table="Math" row="500" id="integral" description=""/>
        <symbol table="Math" row="510" id="integral_anti_cont" description=""/>
        <symbol table="Math" row="520" id="integral_clock" description=""/>
        <symbol table="Math" row="530" id="integral_clock_cont" description=""/>
        <symbol table="Math" row="540" id="intersect" description=""/>
        <symbol table="Math" row="550" id="isin" description=""/>
        <symbol table="Math" row="560" id="italicf" description=""/>
        <symbol table="Math" row="570" id="ket" description=""/>
        <symbol table="Math" row="580" id="lceiling" description=""/>
        <symbol table="Math" row="590" id="leftgrint" description=""/>
        <symbol table="Math" row="600" id="lessorequal" description=""/>
        <symbol table="Math" row="610" id="lessorequal_acc" description=""/>
        <symbol table="Math" row="620" id="lessthan" description=""/>
        <symbol table="Math" row="630" id="lfloor" description=""/>
        <symbol table="Math" row="640" id="lineint" description=""/>
        <symbol table="Math" row="650" id="minus" description=""/>
        <symbol table="Math" row="660" id="minus_acc" description=""/>
        <symbol table="Math" row="670" id="minusplus" description=""/>
        <symbol table="Math" row="680" id="minusplus_acc" description=""/>
        <symbol table="Math" row="690" id="muchgreaterthan" description=""/>
        <symbol table="Math" row="700" id="muchlessthan" description=""/>
        <symbol table="Math" row="710" id="multiply" description=""/>
        <symbol table="Math" row="720" id="nabla" description=""/>
        <symbol table="Math" row="730" id="nabla_acc" description=""/>
        <symbol table="Math" row="740" id="or" description=""/>
        <symbol table="Math" row="750" id="orthogonal" description=""/>
        <symbol table="Math" row="760" id="orthogonalsm" description=""/>
        <symbol table="Math" row="770" id="parallel" description=""/>
        <symbol table="Math" row="780" id="parallel_black" description=""/>
        <symbol table="Math" row="790" id="parallel_s" description=""/>
        <symbol table="Math" row="800" id="parallel_white" description=""/>
        <symbol table="Math" row="810" id="partial" description=""/>
        <symbol table="Math" row="820" id="partialderivative_acc" description=""/>
        <symbol table="Math" row="830" id="plus" description=""/>
        <symbol table="Math" row="840" id="plusminus" description=""/>
        <symbol table="Math" row="850" id="plusminus_acc" description=""/>
        <symbol table="Math" row="860" id="rceiling" description=""/>
        <symbol table="Math" row="880" id="repzero" description=""/>
        <symbol table="Math" row="900" id="rfloor" description=""/>
        <symbol table="Math" row="910" id="rightangle" description=""/>
        <symbol table="Math" row="920" id="rightgrint" description=""/>
        <symbol table="Math" row="930" id="sqrt" description=""/>
        <symbol table="Math" row="940" id="squareminus" description=""/>
        <symbol table="Math" row="950" id="squareplus" description=""/>
        <symbol table="Math" row="960" id="subset" description=""/>
        <symbol table="Math" row="970" id="subseteq" description=""/>
        <symbol table="Math" row="980" id="subsetneq" description=""/>
        <symbol table="Math" row="990" id="subset_neq" description=""/>
        <symbol table="Math" row="1000" id="thereexists" description=""/>
        <symbol table="Math" row="1010" id="therefore" description=""/>
        <symbol table="Math" row="1020" id="times" description=""/>
        <symbol table="Math" row="1030" id="times_acc" description=""/>
        <symbol table="Math" row="1040" id="triangleminus" description=""/>
        <symbol table="Math" row="1050" id="triangleplus" description=""/>
        <symbol table="Math" row="1060" id="tripleintegral" description=""/>
        <symbol table="Math" row="1070" id="tripleprime" description=""/>
        <symbol table="Math" row="1080" id="union" description=""/>
        <symbol table="Math" row="1090" id="vecstart" description=""/>
        <symbol table="Math" row="1100" id="vecstop" description=""/>
        <symbol table="Miscellaneous" row="" id="bullseye" description=""/>
        <symbol table="Miscellaneous" row="" id="caduceus" description=""/>
        <symbol table="Miscellaneous" row="" id="check" description=""/>
        <symbol table="Miscellaneous" row="" id="circle_black" description=""/>
        <symbol table="Miscellaneous" row="" id="circle_black_do" description=""/>
        <symbol table="Miscellaneous" row="" id="circle_black_lf" description=""/>
        <symbol table="Miscellaneous" row="" id="circle_black_rt" description=""/>
        <symbol table="Miscellaneous" row="" id="circle_black_up" description=""/>
        <symbol table="Miscellaneous" row="" id="circle_overlay" description=""/>
        <symbol table="Miscellaneous" row="" id="circle_white" description=""/>
        <symbol table="Miscellaneous" row="" id="clubs" description=""/>
        <symbol table="Miscellaneous" row="" id="cross_grey3" description=""/>
        <symbol table="Miscellaneous" row="" id="diamond_black" description=""/>
        <symbol table="Miscellaneous" row="" id="diamond_op" description=""/>
        <symbol table="Miscellaneous" row="" id="diamond_overlay" description=""/>
        <symbol table="Miscellaneous" row="" id="diamond_white" description=""/>
        <symbol table="Miscellaneous" row="" id="diamonds" description=""/>
        <symbol table="Miscellaneous" row="" id="diams" description=""/>
        <symbol table="Miscellaneous" row="" id="female" description=""/>
        <symbol table="Miscellaneous" row="" id="hearts" description=""/>
        <symbol table="Miscellaneous" row="" id="male" description=""/>
        <symbol table="Miscellaneous" row="" id="moon_fi_qrtr" description=""/>
        <symbol table="Miscellaneous" row="" id="moon_la_qrtr" description=""/>
        <symbol table="Miscellaneous" row="" id="numero" description=""/>
        <symbol table="Mu" row="100" id="Mu" description=""/>
        <symbol table="Mu" row="100" id="Mu2" description=""/>
        <symbol table="Mu" row="100" id="Mubar" description=""/>
        <symbol table="Mu" row="100" id="Mudbldot" description=""/>
        <symbol table="Mu" row="100" id="Mudot" description=""/>
        <symbol table="Mu" row="100" id="Muhat" description=""/>
        <symbol table="Mu" row="100" id="Muvec" description=""/>
        <symbol table="Mu" row="100" id="mu" description=""/>
        <symbol table="Mu" row="100" id="mu2" description=""/>
        <symbol table="Mu" row="100" id="mu_acc" description=""/>
        <symbol table="Mu" row="100" id="muarrowbold" description=""/>
        <symbol table="Mu" row="100" id="mubar" description=""/>
        <symbol table="Mu" row="100" id="mudbldot" description=""/>
        <symbol table="Mu" row="100" id="mudot" description=""/>
        <symbol table="Mu" row="100" id="muhat" description=""/>
        <symbol table="Mu" row="100" id="mutilde" description=""/>
        <symbol table="Mu" row="100" id="muvec" description=""/>
        <symbol table="Music" row="" id="music_flat" description=""/>
        <symbol table="Music" row="" id="music_natural" description=""/>
        <symbol table="Music" row="" id="music_sharp" description=""/>
        <symbol table="Music" row="" id="note_16th_beam" description=""/>
        <symbol table="Music" row="" id="note_8th" description=""/>
        <symbol table="Music" row="" id="note_8th_beam" description=""/>
        <symbol table="Music" row="" id="note_qrtr" description=""/>
        <symbol table="N" row="" id="bbN" description=""/>
        <symbol table="N" row="" id="doubleN" description=""/>
        <symbol table="N" row="150" id="Ntilde" description=""/>
        <symbol table="N" row="150" id="ntilde" description=""/>
        <symbol table="N" row="160" id="Nhat" description=""/>
        <symbol table="N" row="160" id="nhat" description=""/>
        <symbol table="N" row="170" id="Nhatbold" description=""/>
        <symbol table="N" row="170" id="nhatbold" description=""/>
        <symbol table="N" row="180" id="Nhatitalic" description=""/>
        <symbol table="N" row="180" id="nhatitalic" description=""/>
        <symbol table="N" row="190" id="nhatbolditalic" description=""/>
        <symbol table="N" row="200" id="Nbar" description=""/>
        <symbol table="N" row="200" id="nbar" description=""/>
        <symbol table="N" row="210" id="Nbarbold" description=""/>
        <symbol table="N" row="210" id="nbarbold" description=""/>
        <symbol table="N" row="220" id="Nbaritalic" description=""/>
        <symbol table="N" row="220" id="nbaritalic" description=""/>
        <symbol table="N" row="230" id="Nbarbolditalic" description=""/>
        <symbol table="N" row="230" id="nbarbolditalic" description=""/>
        <symbol table="N" row="250" id="Narrow" description=""/>
        <symbol table="N" row="250" id="narrow" description=""/>
        <symbol table="N" row="260" id="Narrowbold" description=""/>
        <symbol table="N" row="260" id="narrowbold" description=""/>
        <symbol table="N" row="261" id="vecNbold" description=""/>
        <symbol table="N" row="261" id="vecnbold" description=""/>
        <symbol table="N" row="270" id="Narrowitalic" description=""/>
        <symbol table="N" row="270" id="narrowitalic" description=""/>
        <symbol table="N" row="280" id="Narrowbolditalic" description=""/>
        <symbol table="N" row="280" id="narrowbolditalic" description=""/>
        <symbol table="N" row="290" id="Nvec" description=""/>
        <symbol table="N" row="290" id="nvec" description=""/>
        <symbol table="N" row="300" id="Nvecbold" description=""/>
        <symbol table="N" row="300" id="nvecbold" description=""/>
        <symbol table="N" row="310" id="Nvecitalic" description=""/>
        <symbol table="N" row="310" id="nvecitalic" description=""/>
        <symbol table="N" row="320" id="Nvecbolditalic" description=""/>
        <symbol table="N" row="320" id="nvecbolditalic" description=""/>
        <symbol table="N" row="335" id="calN" description=""/>
        <symbol table="N" row="340" id="circleN" description=""/>
        <symbol table="Nu" row="100" id="Nu" description=""/>
        <symbol table="Nu" row="100" id="Nu2" description=""/>
        <symbol table="Nu" row="100" id="Nubar" description=""/>
        <symbol table="Nu" row="100" id="Nudbldot" description=""/>
        <symbol table="Nu" row="100" id="Nudot" description=""/>
        <symbol table="Nu" row="100" id="Nuhat" description=""/>
        <symbol table="Nu" row="100" id="Nuvec" description=""/>
        <symbol table="Nu" row="100" id="nu" description=""/>
        <symbol table="Nu" row="100" id="nu2" description=""/>
        <symbol table="Nu" row="100" id="nubar" description=""/>
        <symbol table="Nu" row="100" id="nudbldot" description=""/>
        <symbol table="Nu" row="100" id="nudot" description=""/>
        <symbol table="Nu" row="100" id="nuhat" description=""/>
        <symbol table="Nu" row="100" id="nutilde" description=""/>
        <symbol table="Nu" row="100" id="nuvec" description=""/>
        <symbol table="Numbers" row="" id="roman1" description=""/>
        <symbol table="Numbers" row="" id="roman10" description=""/>
        <symbol table="Numbers" row="" id="roman100" description=""/>
        <symbol table="Numbers" row="" id="roman1000" description=""/>
        <symbol table="Numbers" row="" id="roman1000_sm" description=""/>
        <symbol table="Numbers" row="" id="roman100_sm" description=""/>
        <symbol table="Numbers" row="" id="roman10_sm" description=""/>
        <symbol table="Numbers" row="" id="roman11_sm" description=""/>
        <symbol table="Numbers" row="" id="roman12_sm" description=""/>
        <symbol table="Numbers" row="" id="roman1_sm" description=""/>
        <symbol table="Numbers" row="" id="roman2" description=""/>
        <symbol table="Numbers" row="" id="roman2_sm" description=""/>
        <symbol table="Numbers" row="" id="roman3" description=""/>
        <symbol table="Numbers" row="" id="roman3_sm" description=""/>
        <symbol table="Numbers" row="" id="roman4" description=""/>
        <symbol table="Numbers" row="" id="roman4_sm" description=""/>
        <symbol table="Numbers" row="" id="roman5" description=""/>
        <symbol table="Numbers" row="" id="roman50" description=""/>
        <symbol table="Numbers" row="" id="roman500" description=""/>
        <symbol table="Numbers" row="" id="roman500_sm" description=""/>
        <symbol table="Numbers" row="" id="roman50_sm" description=""/>
        <symbol table="Numbers" row="" id="roman5_sm" description=""/>
        <symbol table="Numbers" row="" id="roman6" description=""/>
        <symbol table="Numbers" row="" id="roman6_sm" description=""/>
        <symbol table="Numbers" row="" id="roman7" description=""/>
        <symbol table="Numbers" row="" id="roman7_sm" description=""/>
        <symbol table="Numbers" row="" id="roman8" description=""/>
        <symbol table="Numbers" row="" id="roman8_sm" description=""/>
        <symbol table="Numbers" row="" id="roman9" description=""/>
        <symbol table="Numbers" row="" id="roman9_sm" description=""/>
        <symbol table="Numbers" row="" id="frac12" description=""/>
        <symbol table="Numbers" row="" id="frac14" description=""/>
        <symbol table="Numbers" row="" id="frac34" description=""/>
        <symbol table="O" row="" id="Oslash" description=""/>
        <symbol table="O" row="" id="ocirc" description=""/>
        <symbol table="O" row="" id="ohatred" description=""/>
        <symbol table="O" row="" id="oslash" description=""/>
        <symbol table="O" row="100" id="Oacute" description=""/>
        <symbol table="O" row="100" id="oacute" description=""/>
        <symbol table="O" row="110" id="Ograve" description=""/>
        <symbol table="O" row="110" id="ograve" description=""/>
        <symbol table="O" row="120" id="Ouml" description=""/>
        <symbol table="O" row="120" id="o-umlaut" description=""/>
        <symbol table="O" row="120" id="ouml" description=""/>
        <symbol table="Miscellaneous" row="130" id="odot" description=""/>
        <symbol table="O" row="150" id="Otilde" description=""/>
        <symbol table="O" row="150" id="otilde" description=""/>
        <symbol table="O" row="160" id="Ohat" description=""/>
        <symbol table="O" row="160" id="ohat" description=""/>
        <symbol table="O" row="170" id="Ohatbold" description=""/>
        <symbol table="O" row="170" id="ohatbold" description=""/>
        <symbol table="O" row="180" id="Ohatitalic" description=""/>
        <symbol table="O" row="180" id="ohatitalic" description=""/>
        <symbol table="O" row="190" id="Ohatbolditalic" description=""/>
        <symbol table="O" row="190" id="ohatbolditalic" description=""/>
        <symbol table="O" row="200" id="Obar" description=""/>
        <symbol table="O" row="200" id="obar" description=""/>
        <symbol table="O" row="210" id="Obarbold" description=""/>
        <symbol table="O" row="210" id="obarbold" description=""/>
        <symbol table="O" row="220" id="Obaritalic" description=""/>
        <symbol table="O" row="220" id="obaritalic" description=""/>
        <symbol table="O" row="230" id="Obarbolditalic" description=""/>
        <symbol table="O" row="230" id="obarbolditalic" description=""/>
        <symbol table="O" row="250" id="Oarrow" description=""/>
        <symbol table="O" row="250" id="oarrow" description=""/>
        <symbol table="O" row="260" id="Oarrowbold" description=""/>
        <symbol table="O" row="260" id="oarrowbold" description=""/>
        <symbol table="O" row="261" id="vecObold" description=""/>
        <symbol table="O" row="261" id="vecobold" description=""/>
        <symbol table="O" row="270" id="Oarrowitalic" description=""/>
        <symbol table="O" row="270" id="oarrowitalic" description=""/>
        <symbol table="O" row="280" id="Oarrowbolditalic" description=""/>
        <symbol table="O" row="280" id="oarrowbolditalic" description=""/>
        <symbol table="O" row="290" id="Ovec" description=""/>
        <symbol table="O" row="290" id="ovec" description=""/>
        <symbol table="O" row="300" id="Ovecbold" description=""/>
        <symbol table="O" row="300" id="ovecbold" description=""/>
        <symbol table="O" row="310" id="Ovecitalic" description=""/>
        <symbol table="O" row="310" id="ovecitalic" description=""/>
        <symbol table="O" row="320" id="Ovecbolditalic" description=""/>
        <symbol table="O" row="320" id="ovecbolditalic" description=""/>
        <symbol table="O" row="335" id="calO" description=""/>
        <symbol table="O" row="340" id="circleO" description=""/>
        <symbol table="Omega" row="100" id="Omega" description=""/>
        <symbol table="Omega" row="100" id="Omega2" description=""/>
        <symbol table="Omega" row="100" id="Omegabar" description=""/>
        <symbol table="Omega" row="100" id="Omegadbldot" description=""/>
        <symbol table="Omega" row="100" id="Omegadot" description=""/>
        <symbol table="Omega" row="100" id="Omegahat" description=""/>
        <symbol table="Omega" row="100" id="Omegavec" description=""/>
        <symbol table="Omega" row="100" id="omega" description=""/>
        <symbol table="Omega" row="100" id="omega2" description=""/>
        <symbol table="Omega" row="100" id="omegaarrowbold" description=""/>
        <symbol table="Omega" row="100" id="omegabar" description=""/>
        <symbol table="Omega" row="100" id="omegabold" description=""/>
        <symbol table="Omega" row="100" id="omegadbldot" description=""/>
        <symbol table="Omega" row="100" id="omegadot" description=""/>
        <symbol table="Omega" row="100" id="omegahat" description=""/>
        <symbol table="Omega" row="100" id="omegavec" description=""/>
        <symbol table="Omicron" row="100" id="Omicron" description=""/>
        <symbol table="Omicron" row="100" id="Omicron2" description=""/>
        <symbol table="Omicron" row="100" id="Omicronbar" description=""/>
        <symbol table="Omicron" row="100" id="Omicrondbldot" description=""/>
        <symbol table="Omicron" row="100" id="Omicrondot" description=""/>
        <symbol table="Omicron" row="100" id="Omicronhat" description=""/>
        <symbol table="Omicron" row="100" id="Omicronvec" description=""/>
        <symbol table="Omicron" row="100" id="omicron" description=""/>
        <symbol table="Omicron" row="100" id="omicron2" description=""/>
        <symbol table="Omicron" row="100" id="omicronbar" description=""/>
        <symbol table="Omicron" row="100" id="omicrondbldot" description=""/>
        <symbol table="Omicron" row="100" id="omicrondot" description=""/>
        <symbol table="Omicron" row="100" id="omicronhat" description=""/>
        <symbol table="Omicron" row="100" id="omicronvec" description=""/>
        <symbol table="Other_Letters" row="" id="THORN" description=""/>
        <symbol table="Other_Letters" row="" id="thorn" description=""/>
        <symbol table="P" row="" id="bbP" description=""/>
        <symbol table="P" row="" id="doubleP" description=""/>
        <symbol table="P" row="150" id="ptilde" description=""/>
        <symbol table="P" row="160" id="Phat" description=""/>
        <symbol table="P" row="160" id="phat" description=""/>
        <symbol table="P" row="170" id="Phatbold" description=""/>
        <symbol table="P" row="170" id="phatbold" description=""/>
        <symbol table="P" row="180" id="Phatitalic" description=""/>
        <symbol table="P" row="180" id="phatitalic" description=""/>
        <symbol table="P" row="190" id="Phatbolditalic" description=""/>
        <symbol table="P" row="190" id="phatbolditalic" description=""/>
        <symbol table="P" row="200" id="Pbar" description=""/>
        <symbol table="P" row="200" id="pbar" description=""/>
        <symbol table="P" row="210" id="Pbarbold" description=""/>
        <symbol table="P" row="210" id="pbarbold" description=""/>
        <symbol table="P" row="220" id="Pbaritalic" description=""/>
        <symbol table="P" row="220" id="pbaritalic" description=""/>
        <symbol table="P" row="230" id="Pbarbolditalic" description=""/>
        <symbol table="P" row="230" id="pbarbolditalic" description=""/>
        <symbol table="P" row="250" id="Parrow" description=""/>
        <symbol table="P" row="250" id="parrow" description=""/>
        <symbol table="P" row="260" id="Parrowbold" description=""/>
        <symbol table="P" row="260" id="parrowbold" description=""/>
        <symbol table="P" row="261" id="vecPbold" description=""/>
        <symbol table="P" row="261" id="vecpbold" description=""/>
        <symbol table="P" row="270" id="Parrowitalic" description=""/>
        <symbol table="P" row="270" id="parrowitalic" description=""/>
        <symbol table="P" row="280" id="Parrowbolditalic" description=""/>
        <symbol table="P" row="280" id="parrowbolditalic" description=""/>
        <symbol table="P" row="290" id="Pvec" description=""/>
        <symbol table="P" row="290" id="pvec" description=""/>
        <symbol table="P" row="300" id="Pvecbold" description=""/>
        <symbol table="P" row="300" id="pvecbold" description=""/>
        <symbol table="P" row="310" id="Pvecitalic" description=""/>
        <symbol table="P" row="310" id="pvecitalic" description=""/>
        <symbol table="P" row="320" id="Pvecbolditalic" description=""/>
        <symbol table="P" row="320" id="pvecbolditalic" description=""/>
        <symbol table="P" row="330" id="scriptP" description=""/>
        <symbol table="P" row="330" id="scriptp" description=""/>
        <symbol table="P" row="335" id="calP" description=""/>
        <symbol table="P" row="340" id="circleP" description=""/>
        <symbol table="Phi" row="100" id="Phi" description=""/>
        <symbol table="Phi" row="100" id="Phi2" description=""/>
        <symbol table="Phi" row="100" id="Phibar" description=""/>
        <symbol table="Phi" row="100" id="Phidbldot" description=""/>
        <symbol table="Phi" row="100" id="Phidot" description=""/>
        <symbol table="Phi" row="100" id="Phihat" description=""/>
        <symbol table="Phi" row="100" id="Phivec" description=""/>
        <symbol table="Phi" row="100" id="phi" description=""/>
        <symbol table="Phi" row="100" id="phi1" description=""/>
        <symbol table="Phi" row="100" id="phi2" description=""/>
        <symbol table="Phi" row="100" id="phi_acc" description=""/>
        <symbol table="Phi" row="100" id="phibar" description=""/>
        <symbol table="Phi" row="100" id="phibold" description=""/>
        <symbol table="Phi" row="100" id="phidbldot" description=""/>
        <symbol table="Phi" row="100" id="phidot" description=""/>
        <symbol table="Phi" row="100" id="phihat" description=""/>
        <symbol table="Phi" row="100" id="phihatbold" description=""/>
        <symbol table="Phi" row="100" id="phioverline" description=""/>
        <symbol table="Phi" row="100" id="phism" description=""/>
        <symbol table="Phi" row="100" id="phivec" description=""/>
        <symbol table="Pi" row="100" id="Pi" description=""/>
        <symbol table="Pi" row="100" id="Pi2" description=""/>
        <symbol table="Pi" row="100" id="Pibar" description=""/>
        <symbol table="Pi" row="100" id="Pidbldot" description=""/>
        <symbol table="Pi" row="100" id="Pidot" description=""/>
        <symbol table="Pi" row="100" id="Pihat" description=""/>
        <symbol table="Pi" row="100" id="Pivec" description=""/>
        <symbol table="Pi" row="100" id="pi" description=""/>
        <symbol table="Pi" row="100" id="pi2" description=""/>
        <symbol table="Pi" row="100" id="pi_acc" description=""/>
        <symbol table="Pi" row="100" id="pibar" description=""/>
        <symbol table="Pi" row="100" id="pidbldot" description=""/>
        <symbol table="Pi" row="100" id="pidot" description=""/>
        <symbol table="Pi" row="100" id="pihat" description=""/>
        <symbol table="Pi" row="100" id="pivec" description=""/>
        <symbol table="Psi" row="100" id="Psi" description=""/>
        <symbol table="Psi" row="100" id="Psi2" description=""/>
        <symbol table="Psi" row="100" id="Psibar" description=""/>
        <symbol table="Psi" row="100" id="Psidbldot" description=""/>
        <symbol table="Psi" row="100" id="Psidot" description=""/>
        <symbol table="Psi" row="100" id="Psihat" description=""/>
        <symbol table="Psi" row="100" id="Psivec" description=""/>
        <symbol table="Psi" row="100" id="psi" description=""/>
        <symbol table="Psi" row="100" id="psi2" description=""/>
        <symbol table="Psi" row="100" id="psibar" description=""/>
        <symbol table="Psi" row="100" id="psidbldot" description=""/>
        <symbol table="Psi" row="100" id="psidot" description=""/>
        <symbol table="Psi" row="100" id="psihat" description=""/>
        <symbol table="Psi" row="100" id="psivec" description=""/>
        <symbol table="Punctuation" row="" id="acute" description=""/>
        <symbol table="Punctuation" row="" id="bdagger" description=""/>
        <symbol table="Punctuation" row="" id="bddagger" description=""/>
        <symbol table="Punctuation" row="" id="circumflex" description=""/>
        <symbol table="Punctuation" row="" id="dagger" description=""/>
        <symbol table="Punctuation" row="" id="underscore" description=""/>
        <symbol table="Punctuation" row="" id="rsquote" description=""/>
        <symbol table="Punctuation" row="" id="section" description=""/>
        <symbol table="Punctuation" row="" id="semicolon" description=""/>
        <symbol table="Punctuation" row="" id="singlequote" description=""/>
        <symbol table="Punctuation" row="" id="ampersand" description=""/>
        <symbol table="Punctuation" row="" id="apostrophe" description=""/>
        <symbol table="Punctuation" row="" id="asterisk" description=""/>
        <symbol table="Punctuation" row="" id="at" description=""/>
        <symbol table="Punctuation" row="" id="backslash" description=""/>
        <symbol table="Punctuation" row="" id="bullet" description=""/>
        <symbol table="Punctuation" row="" id="bullet_op" description=""/>
        <symbol table="Punctuation" row="" id="caret" description=""/>
        <symbol table="Punctuation" row="" id="caret_sm" description=""/>
        <symbol table="Punctuation" row="" id="colon" description=""/>
        <symbol table="Punctuation" row="" id="comma" description=""/>
        <symbol table="Punctuation" row="" id="copy" description=""/>
        <symbol table="Punctuation" row="" id="copyright" description=""/>
        <symbol table="Punctuation" row="" id="diaeresis" description=""/>
        <symbol table="Punctuation" row="" id="exclamation" description=""/>
        <symbol table="Punctuation" row="" id="fullstop" description=""/>
        <symbol table="Punctuation" row="" id="grave" description=""/>
        <symbol table="Punctuation" row="" id="hashmark" description=""/>
        <symbol table="Punctuation" row="" id="hyphen" description=""/>
        <symbol table="Punctuation" row="" id="hyphen_nobr" description=""/>
        <symbol table="Punctuation" row="" id="inv_question" description=""/>
        <symbol table="Punctuation" row="" id="ldquote" description=""/>
        <symbol table="Punctuation" row="" id="left_dbl_bar" description=""/>
        <symbol table="Punctuation" row="" id="leftbracket" description=""/>
        <symbol table="Punctuation" row="" id="leftcurly" description=""/>
        <symbol table="Punctuation" row="" id="leftparens" description=""/>
        <symbol table="Punctuation" row="" id="lsquote" description=""/>
        <symbol table="Punctuation" row="" id="ndash" description=""/>
        <symbol table="Punctuation" row="" id="overline" description=""/>
        <symbol table="Punctuation" row="" id="period" description=""/>
        <symbol table="Punctuation" row="" id="question" description=""/>
        <symbol table="Punctuation" row="" id="rdquote" description=""/>
        <symbol table="Punctuation" row="" id="doublequote" description=""/>
        <symbol table="Punctuation" row="" id="interrobang" description=""/>
        <symbol table="Punctuation" row="" id="inv_exclamation" description=""/>
        <symbol table="Punctuation" row="" id="mdash" description=""/>
        <symbol table="Punctuation" row="" id="paragraph" description=""/>
        <symbol table="Q" row="" id="bbQ" description=""/>
        <symbol table="Q" row="" id="bbQprime" description=""/>
        <symbol table="Q" row="" id="calQsm" description=""/>
        <symbol table="Q" row="" id="doubleQ" description=""/>
        <symbol table="Q" row="160" id="Qhat" description=""/>
        <symbol table="Q" row="160" id="qhat" description=""/>
        <symbol table="Q" row="170" id="Qhatbold" description=""/>
        <symbol table="Q" row="170" id="qhatbold" description=""/>
        <symbol table="Q" row="180" id="Qhatitalic" description=""/>
        <symbol table="Q" row="180" id="qhatitalic" description=""/>
        <symbol table="Q" row="190" id="Qhatbolditalic" description=""/>
        <symbol table="Q" row="190" id="qhatbolditalic" description=""/>
        <symbol table="Q" row="200" id="Qbar" description=""/>
        <symbol table="Q" row="200" id="qbar" description=""/>
        <symbol table="Q" row="210" id="Qbarbold" description=""/>
        <symbol table="Q" row="210" id="qbarbold" description=""/>
        <symbol table="Q" row="220" id="Qbaritalic" description=""/>
        <symbol table="Q" row="220" id="qbaritalic" description=""/>
        <symbol table="Q" row="230" id="Qbarbolditalic" description=""/>
        <symbol table="Q" row="230" id="qbarbolditalic" description=""/>
        <symbol table="Q" row="250" id="Qarrow" description=""/>
        <symbol table="Q" row="250" id="qarrow" description=""/>
        <symbol table="Q" row="260" id="Qarrowbold" description=""/>
        <symbol table="Q" row="260" id="qarrowbold" description=""/>
        <symbol table="Q" row="261" id="vecQbold" description=""/>
        <symbol table="Q" row="261" id="vecqbold" description=""/>
        <symbol table="Q" row="270" id="Qarrowitalic" description=""/>
        <symbol table="Q" row="270" id="qarrowitalic" description=""/>
        <symbol table="Q" row="280" id="Qarrowbolditalic" description=""/>
        <symbol table="Q" row="280" id="qarrowbolditalic" description=""/>
        <symbol table="Q" row="290" id="Qvec" description=""/>
        <symbol table="Q" row="290" id="qvec" description=""/>
        <symbol table="Q" row="300" id="Qvecbold" description=""/>
        <symbol table="Q" row="300" id="qvecbold" description=""/>
        <symbol table="Q" row="310" id="Qvecitalic" description=""/>
        <symbol table="Q" row="310" id="qvecitalic" description=""/>
        <symbol table="Q" row="320" id="Qvecbolditalic" description=""/>
        <symbol table="Q" row="320" id="qvecbolditalic" description=""/>
        <symbol table="Q" row="335" id="calQ" description=""/>
        <symbol table="R" row="" id="bbR" description=""/>
        <symbol table="R" row="" id="calRsm" description=""/>
        <symbol table="R" row="" id="doubleR" description=""/>
        <symbol table="R" row="130" id="rdot" description=""/>
        <symbol table="R" row="140" id="rdbldot" description=""/>
        <symbol table="R" row="160" id="Rhat" description=""/>
        <symbol table="R" row="160" id="rhat" description=""/>
        <symbol table="R" row="170" id="Rhatbold" description=""/>
        <symbol table="R" row="170" id="rhatbold" description=""/>
        <symbol table="R" row="180" id="Rhatitalic" description=""/>
        <symbol table="R" row="180" id="rhatitalic" description=""/>
        <symbol table="R" row="190" id="Rhatbolditalic" description=""/>
        <symbol table="R" row="190" id="rhatbolditalic" description=""/>
        <symbol table="R" row="200" id="Rbar" description=""/>
        <symbol table="R" row="200" id="rbar" description=""/>
        <symbol table="R" row="210" id="rbarbold" description=""/>
        <symbol table="R" row="220" id="Rbaritalic" description=""/>
        <symbol table="R" row="220" id="rbaritalic" description=""/>
        <symbol table="R" row="230" id="rbarbolditalic" description=""/>
        <symbol table="R" row="250" id="Rarrow" description=""/>
        <symbol table="R" row="250" id="rarrow" description=""/>
        <symbol table="R" row="260" id="Rarrowbold" description=""/>
        <symbol table="R" row="260" id="rarrowbold" description=""/>
        <symbol table="R" row="261" id="vecRbold" description=""/>
        <symbol table="R" row="261" id="vecrbold" description=""/>
        <symbol table="R" row="270" id="Rarrowitalic" description=""/>
        <symbol table="R" row="270" id="rarrowitalic" description=""/>
        <symbol table="R" row="280" id="Rarrowbolditalic" description=""/>
        <symbol table="R" row="280" id="rarrowbolditalic" description=""/>
        <symbol table="R" row="290" id="Rvec" description=""/>
        <symbol table="R" row="290" id="rvec" description=""/>
        <symbol table="R" row="300" id="Rvecbold" description=""/>
        <symbol table="R" row="300" id="rvecbold" description=""/>
        <symbol table="R" row="310" id="Rvecitalic" description=""/>
        <symbol table="R" row="310" id="rvecitalic" description=""/>
        <symbol table="R" row="320" id="Rvecbolditalic" description=""/>
        <symbol table="R" row="320" id="rvecbolditalic" description=""/>
        <symbol table="R" row="330" id="scriptR" description=""/>
        <symbol table="R" row="335" id="calR" description=""/>
        <symbol table="R" row="340" id="circleR" description=""/>
        <symbol table="Rho" row="100" id="Rho" description=""/>
        <symbol table="Rho" row="100" id="Rho2" description=""/>
        <symbol table="Rho" row="100" id="Rhobar" description=""/>
        <symbol table="Rho" row="100" id="Rhodbldot" description=""/>
        <symbol table="Rho" row="100" id="Rhodot" description=""/>
        <symbol table="Rho" row="100" id="Rhohat" description=""/>
        <symbol table="Rho" row="100" id="Rhovec" description=""/>
        <symbol table="Rho" row="100" id="rho" description=""/>
        <symbol table="Rho" row="100" id="rho2" description=""/>
        <symbol table="Rho" row="100" id="rho_acc" description=""/>
        <symbol table="Rho" row="100" id="rhobar" description=""/>
        <symbol table="Rho" row="100" id="rhodbldot" description=""/>
        <symbol table="Rho" row="100" id="rhodot" description=""/>
        <symbol table="Rho" row="100" id="rhohat" description=""/>
        <symbol table="Rho" row="100" id="rhovec" description=""/>
        <symbol table="S" row="" id="Scaron" description=""/>
        <symbol table="S" row="" id="scaron" description=""/>
        <symbol table="S" row="" id="calS_bold" description=""/>
        <symbol table="S" row="" id="calSsm" description=""/>
        <symbol table="S" row="" id="calSsm_bold" description=""/>
        <symbol table="S" row="130" id="sdot" description=""/>
        <symbol table="S" row="160" id="Shat" description=""/>
        <symbol table="S" row="160" id="shat" description=""/>
        <symbol table="S" row="170" id="Shatbold" description=""/>
        <symbol table="S" row="170" id="shatbold" description=""/>
        <symbol table="S" row="180" id="Shatitalic" description=""/>
        <symbol table="S" row="180" id="shatitalic" description=""/>
        <symbol table="S" row="190" id="Shatbolditalic" description=""/>
        <symbol table="S" row="190" id="shatbolditalic" description=""/>
        <symbol table="S" row="200" id="Sbar" description=""/>
        <symbol table="S" row="200" id="sbar" description=""/>
        <symbol table="S" row="210" id="Sbarbold" description=""/>
        <symbol table="S" row="210" id="sbarbold" description=""/>
        <symbol table="S" row="220" id="Sbaritalic" description=""/>
        <symbol table="S" row="220" id="sbaritalic" description=""/>
        <symbol table="S" row="230" id="Sbarbolditalic" description=""/>
        <symbol table="S" row="230" id="sbarbolditalic" description=""/>
        <symbol table="S" row="250" id="Sarrow" description=""/>
        <symbol table="S" row="250" id="sarrow" description=""/>
        <symbol table="S" row="260" id="Sarrowbold" description=""/>
        <symbol table="S" row="260" id="sarrowbold" description=""/>
        <symbol table="S" row="261" id="vecSbold" description=""/>
        <symbol table="S" row="261" id="vecsbold" description=""/>
        <symbol table="S" row="270" id="Sarrowitalic" description=""/>
        <symbol table="S" row="270" id="sarrowitalic" description=""/>
        <symbol table="S" row="280" id="Sarrowbolditalic" description=""/>
        <symbol table="S" row="280" id="sarrowbolditalic" description=""/>
        <symbol table="S" row="290" id="svec" description=""/>
        <symbol table="S" row="300" id="Svecbold" description=""/>
        <symbol table="S" row="300" id="svecbold" description=""/>
        <symbol table="S" row="310" id="Svecitalic" description=""/>
        <symbol table="S" row="310" id="svecitalic" description=""/>
        <symbol table="S" row="320" id="Svecbolditalic" description=""/>
        <symbol table="S" row="320" id="svecbolditalic" description=""/>
        <symbol table="S" row="335" id="calS" description=""/>
        <symbol table="S" row="340" id="circleS" description=""/>
        <symbol table="Sigma" row="100" id="Sigma" description=""/>
        <symbol table="Sigma" row="100" id="Sigma2" description=""/>
        <symbol table="Sigma" row="100" id="Sigmabar" description=""/>
        <symbol table="Sigma" row="100" id="Sigmadbldot" description=""/>
        <symbol table="Sigma" row="100" id="Sigmadot" description=""/>
        <symbol table="Sigma" row="100" id="Sigmahat" description=""/>
        <symbol table="Sigma" row="100" id="Sigmavec" description=""/>
        <symbol table="Sigma" row="100" id="sigma" description=""/>
        <symbol table="Sigma" row="100" id="sigma2" description=""/>
        <symbol table="Sigma" row="100" id="sigma_acc" description=""/>
        <symbol table="Sigma" row="100" id="sigmabar" description=""/>
        <symbol table="Sigma" row="100" id="sigmadbldot" description=""/>
        <symbol table="Sigma" row="100" id="sigmadot" description=""/>
        <symbol table="Sigma" row="100" id="sigmaf" description=""/>
        <symbol table="Sigma" row="100" id="sigmahat" description=""/>
        <symbol table="Sigma" row="100" id="sigmavec" description=""/>
        <symbol table="Spaces" row="100" id="tab" description=""/>
        <symbol table="Spaces" row="110" id="space" description="space"/>
        <symbol table="Spaces" row="120" id="thinsp" description="thin space"/>
        <symbol table="Spaces" row="130" id="thinsp_acc" description="thin space"/>
        <symbol table="Spaces" row="140" id="space_nobr" description="non-breaking space"/>
        <symbol table="Spaces" row="150" id="double" description="2 non-breaking spaces"/>
        <symbol table="Spaces" row="160" id="quad" description="4 non-breaking spaces"/>
        <symbol table="T" row="" id="calTsm" description=""/>
        <symbol table="T" row="160" id="That" description=""/>
        <symbol table="T" row="160" id="that" description=""/>
        <symbol table="T" row="170" id="Thatbold" description=""/>
        <symbol table="T" row="170" id="thatbold" description=""/>
        <symbol table="T" row="180" id="Thatitalic" description=""/>
        <symbol table="T" row="180" id="thatitalic" description=""/>
        <symbol table="T" row="190" id="Thatbolditalic" description=""/>
        <symbol table="T" row="190" id="thatbolditalic" description=""/>
        <symbol table="T" row="200" id="Tbar" description=""/>
        <symbol table="T" row="200" id="tbar" description=""/>
        <symbol table="T" row="210" id="Tbarbold" description=""/>
        <symbol table="T" row="210" id="tbarbold" description=""/>
        <symbol table="T" row="220" id="Tbaritalic" description=""/>
        <symbol table="T" row="220" id="tbaritalic" description=""/>
        <symbol table="T" row="230" id="Tbarbolditalic" description=""/>
        <symbol table="T" row="230" id="tbarbolditalic" description=""/>
        <symbol table="T" row="250" id="Tarrow" description=""/>
        <symbol table="T" row="250" id="tarrow" description=""/>
        <symbol table="T" row="260" id="Tarrowbold" description=""/>
        <symbol table="T" row="260" id="tarrowbold" description=""/>
        <symbol table="T" row="261" id="vecTbold" description=""/>
        <symbol table="T" row="261" id="vectbold" description=""/>
        <symbol table="T" row="270" id="Tarrowitalic" description=""/>
        <symbol table="T" row="270" id="tarrowitalic" description=""/>
        <symbol table="T" row="280" id="Tarrowbolditalic" description=""/>
        <symbol table="T" row="290" id="Tvec" description=""/>
        <symbol table="T" row="290" id="tvec" description=""/>
        <symbol table="T" row="300" id="Tvecbold" description=""/>
        <symbol table="T" row="300" id="tvecbold" description=""/>
        <symbol table="T" row="310" id="Tvecitalic" description=""/>
        <symbol table="T" row="310" id="tvecitalic" description=""/>
        <symbol table="T" row="320" id="Tvecbolditalic" description=""/>
        <symbol table="T" row="320" id="tvecbolditalic" description=""/>
        <symbol table="T" row="335" id="calT" description=""/>
        <symbol table="T" row="340" id="circleT" description=""/>
        <symbol table="Tau" row="100" id="Tau" description=""/>
        <symbol table="Tau" row="100" id="Tau2" description=""/>
        <symbol table="Tau" row="100" id="Taubar" description=""/>
        <symbol table="Tau" row="100" id="Taudbldot" description=""/>
        <symbol table="Tau" row="100" id="Taudot" description=""/>
        <symbol table="Tau" row="100" id="Tauhat" description=""/>
        <symbol table="Tau" row="100" id="Tauvec" description=""/>
        <symbol table="Tau" row="100" id="tau" description=""/>
        <symbol table="Tau" row="100" id="tau2" description=""/>
        <symbol table="Tau" row="100" id="tauarrowbold" description=""/>
        <symbol table="Tau" row="100" id="taubar" description=""/>
        <symbol table="Tau" row="100" id="taubold" description=""/>
        <symbol table="Tau" row="100" id="taudbldot" description=""/>
        <symbol table="Tau" row="100" id="taudot" description=""/>
        <symbol table="Tau" row="100" id="tauhat" description=""/>
        <symbol table="Tau" row="100" id="tauhatbold" description=""/>
        <symbol table="Tau" row="100" id="tauvec" description=""/>
        <symbol table="Theta" row="100" id="Theta" description=""/>
        <symbol table="Theta" row="100" id="Theta2" description=""/>
        <symbol table="Theta" row="100" id="Thetabar" description=""/>
        <symbol table="Theta" row="100" id="Thetadbldot" description=""/>
        <symbol table="Theta" row="100" id="Thetadot" description=""/>
        <symbol table="Theta" row="100" id="Thetahat" description=""/>
        <symbol table="Theta" row="100" id="Thetavec" description=""/>
        <symbol table="Theta" row="100" id="theta" description=""/>
        <symbol table="Theta" row="100" id="theta2" description=""/>
        <symbol table="Theta" row="100" id="thetabar" description=""/>
        <symbol table="Theta" row="100" id="thetabold" description=""/>
        <symbol table="Theta" row="100" id="thetadbldot" description=""/>
        <symbol table="Theta" row="100" id="thetadot" description=""/>
        <symbol table="Theta" row="100" id="thetahat" description=""/>
        <symbol table="Theta" row="100" id="thetahatbold" description=""/>
        <symbol table="Theta" row="100" id="thetasmall" description=""/>
        <symbol table="Theta" row="100" id="thetatilde" description=""/>
        <symbol table="Theta" row="100" id="thetavec" description=""/>
        <symbol table="Triangles" row="" id="triangle_black_down" description=""/>
        <symbol table="Triangles" row="" id="triangle_black_lf" description=""/>
        <symbol table="Triangles" row="" id="triangle_black_rt" description=""/>
        <symbol table="Triangles" row="" id="triangle_black_up" description=""/>
        <symbol table="Triangles" row="" id="triangle_ne" description=""/>
        <symbol table="Triangles" row="" id="triangle_nw" description=""/>
        <symbol table="Triangles" row="" id="triangle_rt" description=""/>
        <symbol table="Triangles" row="" id="triangle_se" description=""/>
        <symbol table="Triangles" row="" id="triangle_sw" description=""/>
        <symbol table="Triangles" row="" id="triangle_white_do" description=""/>
        <symbol table="Triangles" row="" id="triangle_white_lf" description=""/>
        <symbol table="Triangles" row="" id="triangle_white_rt" description=""/>
        <symbol table="Triangles" row="" id="triangle_white_up" description=""/>
        <symbol table="Triangles" row="" id="triangledown" description=""/>
        <symbol table="Triangles" row="" id="triangleleft" description=""/>
        <symbol table="Triangles" row="" id="triangleright" description=""/>
        <symbol table="Triangles" row="" id="triangleup" description=""/>
        <symbol table="U" row="" id="Ucirc" description=""/>
        <symbol table="U" row="" id="ucirc" description=""/>
        <symbol table="U" row="90" id="ubold" description=""/>
        <symbol table="U" row="100" id="Uacute" description=""/>
        <symbol table="U" row="100" id="uacute" description=""/>
        <symbol table="U" row="110" id="Ugrave" description=""/>
        <symbol table="U" row="110" id="ugrave" description=""/>
        <symbol table="U" row="120" id="Uuml" description=""/>
        <symbol table="U" row="120" id="u-umlaut" description=""/>
        <symbol table="U" row="120" id="uuml" description=""/>
        <symbol table="U" row="150" id="utilde" description=""/>
        <symbol table="U" row="160" id="Uhat" description=""/>
        <symbol table="U" row="160" id="uhat" description=""/>
        <symbol table="U" row="170" id="Uhatbold" description=""/>
        <symbol table="U" row="170" id="uhatbold" description=""/>
        <symbol table="U" row="180" id="Uhatitalic" description=""/>
        <symbol table="U" row="180" id="uhatitalic" description=""/>
        <symbol table="U" row="190" id="Uhatbolditalic" description=""/>
        <symbol table="U" row="190" id="uhatbolditalic" description=""/>
        <symbol table="U" row="200" id="Ubar" description=""/>
        <symbol table="U" row="200" id="ubar" description=""/>
        <symbol table="U" row="210" id="Ubarbold" description=""/>
        <symbol table="U" row="210" id="ubarbold" description=""/>
        <symbol table="U" row="220" id="Ubaritalic" description=""/>
        <symbol table="U" row="220" id="ubaritalic" description=""/>
        <symbol table="U" row="230" id="Ubarbolditalic" description=""/>
        <symbol table="U" row="230" id="ubarbolditalic" description=""/>
        <symbol table="U" row="250" id="Uarrow" description=""/>
        <symbol table="U" row="260" id="Uarrowbold" description=""/>
        <symbol table="U" row="260" id="uarrowbold" description=""/>
        <symbol table="U" row="261" id="vecUbold" description=""/>
        <symbol table="U" row="261" id="vecubold" description=""/>
        <symbol table="U" row="270" id="Uarrowitalic" description=""/>
        <symbol table="U" row="270" id="uarrowitalic" description=""/>
        <symbol table="U" row="280" id="Uarrowbolditalic" description=""/>
        <symbol table="U" row="280" id="uarrowbolditalic" description=""/>
        <symbol table="U" row="290" id="Uvec" description=""/>
        <symbol table="U" row="290" id="uvec" description=""/>
        <symbol table="U" row="300" id="Uvecbold" description=""/>
        <symbol table="U" row="310" id="Uvecitalic" description=""/>
        <symbol table="U" row="310" id="uvecitalic" description=""/>
        <symbol table="U" row="320" id="Uvecbolditalic" description=""/>
        <symbol table="U" row="320" id="uvecbolditalic" description=""/>
        <symbol table="U" row="330" id="scriptU" description=""/>
        <symbol table="U" row="340" id="circleU" description=""/>
        <symbol table="Units" row="" id="yen" description=""/>
        <symbol table="Units" row="" id="Angstrom" description=""/>
        <symbol table="Units" row="" id="angstrom" description=""/>
        <symbol table="Units" row="" id="cents" description=""/>
        <symbol table="Units" row="" id="currency" description=""/>
        <symbol table="Units" row="" id="dollar" description=""/>
        <symbol table="Units" row="" id="euro" description=""/>
        <symbol table="Units" row="" id="permille" description=""/>
        <symbol table="Units" row="" id="redcents" description=""/>
        <symbol table="Units" row="" id="degC" description=""/>
        <symbol table="Units" row="" id="degF" description=""/>
        <symbol table="Units" row="" id="kelvin" description=""/>
        <symbol table="Units" row="" id="micro" description=""/>
        <symbol table="Units" row="" id="micro2" description=""/>
        <symbol table="Units" row="" id="ohm" description=""/>
        <symbol table="Units" row="" id="percent" description=""/>
        <symbol table="Units" row="" id="pound" description=""/>
        <symbol table="Upsilon" row="100" id="Upsilon" description=""/>
        <symbol table="Upsilon" row="100" id="Upsilon2" description=""/>
        <symbol table="Upsilon" row="100" id="Upsilonbar" description=""/>
        <symbol table="Upsilon" row="100" id="Upsilondbldot" description=""/>
        <symbol table="Upsilon" row="100" id="Upsilondot" description=""/>
        <symbol table="Upsilon" row="100" id="Upsilonhat" description=""/>
        <symbol table="Upsilon" row="100" id="Upsilonvec" description=""/>
        <symbol table="Upsilon" row="100" id="upsilon" description=""/>
        <symbol table="Upsilon" row="100" id="upsilon2" description=""/>
        <symbol table="Upsilon" row="100" id="upsilonbar" description=""/>
        <symbol table="Upsilon" row="100" id="upsilondbldot" description=""/>
        <symbol table="Upsilon" row="100" id="upsilondot" description=""/>
        <symbol table="Upsilon" row="100" id="upsilonhat" description=""/>
        <symbol table="Upsilon" row="100" id="upsilonvec" description=""/>
        <symbol table="V" row="90" id="vbold" description=""/>
        <symbol table="V" row="130" id="Vdot" description=""/>
        <symbol table="V" row="150" id="vtilde" description=""/>
        <symbol table="V" row="160" id="Vhat" description=""/>
        <symbol table="V" row="160" id="vhat" description=""/>
        <symbol table="V" row="170" id="Vhatbold" description=""/>
        <symbol table="V" row="170" id="vhatbold" description=""/>
        <symbol table="V" row="180" id="Vhatitalic" description=""/>
        <symbol table="V" row="180" id="vhatitalic" description=""/>
        <symbol table="V" row="190" id="Vhatbolditalic" description=""/>
        <symbol table="V" row="190" id="vhatbolditalic" description=""/>
        <symbol table="V" row="200" id="Vbar" description=""/>
        <symbol table="V" row="200" id="vbar" description=""/>
        <symbol table="V" row="210" id="Vbarbold" description=""/>
        <symbol table="V" row="210" id="vbarbold" description=""/>
        <symbol table="V" row="220" id="Vbaritalic" description=""/>
        <symbol table="V" row="220" id="vbaritalic" description=""/>
        <symbol table="V" row="230" id="Vbarbolditalic" description=""/>
        <symbol table="V" row="230" id="vbarbolditalic" description=""/>
        <symbol table="V" row="250" id="Varrow" description=""/>
        <symbol table="V" row="250" id="varrow" description=""/>
        <symbol table="V" row="260" id="Varrowbold" description=""/>
        <symbol table="V" row="260" id="varrowbold" description=""/>
        <symbol table="V" row="261" id="vecVbold" description=""/>
        <symbol table="V" row="261" id="vecvbold" description=""/>
        <symbol table="V" row="270" id="Varrowitalic" description=""/>
        <symbol table="V" row="270" id="varrowitalic" description=""/>
        <symbol table="V" row="280" id="Varrowbolditalic" description=""/>
        <symbol table="V" row="280" id="varrowbolditalic" description=""/>
        <symbol table="V" row="290" id="Vvec" description=""/>
        <symbol table="V" row="290" id="vvec" description=""/>
        <symbol table="V" row="300" id="Vvecbold" description=""/>
        <symbol table="V" row="300" id="vvecbold" description=""/>
        <symbol table="V" row="310" id="Vvecitalic" description=""/>
        <symbol table="V" row="310" id="vvecitalic" description=""/>
        <symbol table="V" row="320" id="Vvecbolditalic" description=""/>
        <symbol table="V" row="320" id="vvecbolditalic" description=""/>
        <symbol table="V" row="330" id="scriptV" description=""/>
        <symbol table="V" row="335" id="calV" description=""/>
        <symbol table="V" row="340" id="circleV" description=""/>
        <symbol table="W" row="" id="bbW" description=""/>
        <symbol table="W" row="" id="calWsm" description=""/>
        <symbol table="W" row="160" id="What" description=""/>
        <symbol table="W" row="160" id="what" description=""/>
        <symbol table="W" row="170" id="Whatbold" description=""/>
        <symbol table="W" row="170" id="whatbold" description=""/>
        <symbol table="W" row="180" id="Whatitalic" description=""/>
        <symbol table="W" row="180" id="whatitalic" description=""/>
        <symbol table="W" row="190" id="Whatbolditalic" description=""/>
        <symbol table="W" row="190" id="whatbolditalic" description=""/>
        <symbol table="W" row="200" id="Wbar" description=""/>
        <symbol table="W" row="200" id="wbar" description=""/>
        <symbol table="W" row="210" id="Wbarbold" description=""/>
        <symbol table="W" row="210" id="wbarbold" description=""/>
        <symbol table="W" row="220" id="Wbaritalic" description=""/>
        <symbol table="W" row="220" id="wbaritalic" description=""/>
        <symbol table="W" row="230" id="Wbarbolditalic" description=""/>
        <symbol table="W" row="230" id="wbarbolditalic" description=""/>
        <symbol table="W" row="250" id="Warrow" description=""/>
        <symbol table="W" row="250" id="warrow" description=""/>
        <symbol table="W" row="260" id="Warrowbold" description=""/>
        <symbol table="W" row="260" id="warrowbold" description=""/>
        <symbol table="W" row="261" id="vecWbold" description=""/>
        <symbol table="W" row="261" id="vecwbold" description=""/>
        <symbol table="W" row="270" id="warrowitalic" description=""/>
        <symbol table="W" row="280" id="Warrowbolditalic" description=""/>
        <symbol table="W" row="280" id="warrowbolditalic" description=""/>
        <symbol table="W" row="290" id="Wvec" description=""/>
        <symbol table="W" row="290" id="wvec" description=""/>
        <symbol table="W" row="300" id="Wvecbold" description=""/>
        <symbol table="W" row="300" id="wvecbold" description=""/>
        <symbol table="W" row="310" id="Wvecitalic" description=""/>
        <symbol table="W" row="310" id="wvecitalic" description=""/>
        <symbol table="W" row="320" id="Wvecbolditalic" description=""/>
        <symbol table="W" row="320" id="wvecbolditalic" description=""/>
        <symbol table="W" row="330" id="scriptw" description=""/>
        <symbol table="W" row="335" id="calW" description=""/>
        <symbol table="W" row="340" id="circleW" description=""/>
        <symbol table="X" row="130" id="xdot" description=""/>
        <symbol table="X" row="140" id="xdbldot" description=""/>
        <symbol table="X" row="150" id="Xtilde" description=""/>
        <symbol table="X" row="150" id="xtilde" description=""/>
        <symbol table="X" row="160" id="Xhat" description=""/>
        <symbol table="X" row="160" id="xhat" description=""/>
        <symbol table="X" row="170" id="Xhatbold" description=""/>
        <symbol table="X" row="170" id="xhatbold" description=""/>
        <symbol table="X" row="180" id="Xhatitalic" description=""/>
        <symbol table="X" row="180" id="xhatitalic" description=""/>
        <symbol table="X" row="185" id="xhatitalicred" description=""/>
        <symbol table="X" row="190" id="Xhatbolditalic" description=""/>
        <symbol table="X" row="190" id="xhatbolditalic" description=""/>
        <symbol table="X" row="195" id="xhatbolditalicred" description=""/>
        <symbol table="X" row="200" id="Xbar" description=""/>
        <symbol table="X" row="200" id="xbar" description=""/>
        <symbol table="X" row="210" id="Xbarbold" description=""/>
        <symbol table="X" row="210" id="xbarbold" description=""/>
        <symbol table="X" row="220" id="Xbaritalic" description=""/>
        <symbol table="X" row="220" id="xbaritalic" description=""/>
        <symbol table="X" row="230" id="Xbarbolditalic" description=""/>
        <symbol table="X" row="230" id="xbarbolditalic" description=""/>
        <symbol table="X" row="240" id="xdblbar" description=""/>
        <symbol table="X" row="250" id="Xarrow" description=""/>
        <symbol table="X" row="250" id="xarrow" description=""/>
        <symbol table="X" row="260" id="Xarrowbold" description=""/>
        <symbol table="X" row="260" id="xarrowbold" description=""/>
        <symbol table="X" row="261" id="vecXbold" description=""/>
        <symbol table="X" row="261" id="vecxbold" description=""/>
        <symbol table="X" row="270" id="Xarrowitalic" description=""/>
        <symbol table="X" row="270" id="xarrowitalic" description=""/>
        <symbol table="X" row="280" id="Xarrowbolditalic" description=""/>
        <symbol table="X" row="280" id="xarrowbolditalic" description=""/>
        <symbol table="X" row="290" id="xvec" description=""/>
        <symbol table="X" row="300" id="Xvecbold" description=""/>
        <symbol table="X" row="300" id="xvecbold" description=""/>
        <symbol table="X" row="310" id="Xvecitalic" description=""/>
        <symbol table="X" row="310" id="xvecitalic" description=""/>
        <symbol table="X" row="320" id="Xvecbolditalic" description=""/>
        <symbol table="X" row="320" id="xvecbolditalic" description=""/>
        <symbol table="X" row="340" id="circleX" description=""/>
        <symbol table="Xi" row="100" id="Xi" description=""/>
        <symbol table="Xi" row="100" id="Xi2" description=""/>
        <symbol table="Xi" row="100" id="Xibar" description=""/>
        <symbol table="Xi" row="100" id="Xidbldot" description=""/>
        <symbol table="Xi" row="100" id="Xidot" description=""/>
        <symbol table="Xi" row="100" id="Xihat" description=""/>
        <symbol table="Xi" row="100" id="Xivec" description=""/>
        <symbol table="Xi" row="100" id="xi" description=""/>
        <symbol table="Xi" row="100" id="xi2" description=""/>
        <symbol table="Xi" row="100" id="xibar" description=""/>
        <symbol table="Xi" row="100" id="xidbldot" description=""/>
        <symbol table="Xi" row="100" id="xidot" description=""/>
        <symbol table="Xi" row="100" id="xihat" description=""/>
        <symbol table="Xi" row="100" id="xivec" description=""/>
        <symbol table="Y" row="" id="ybar_acc" description=""/>
        <symbol table="Y" row="100" id="Yacute" description=""/>
        <symbol table="Y" row="100" id="yacute" description=""/>
        <symbol table="Y" row="120" id="Yuml" description=""/>
        <symbol table="Y" row="120" id="yuml" description=""/>
        <symbol table="Miscellaneous" row="130" id="ydot" description=""/>
        <symbol table="Y" row="140" id="ydbldot" description=""/>
        <symbol table="Y" row="150" id="ytilde" description=""/>
        <symbol table="Y" row="160" id="Yhat" description=""/>
        <symbol table="Y" row="160" id="yhat" description=""/>
        <symbol table="Y" row="170" id="Yhatbold" description=""/>
        <symbol table="Y" row="170" id="yhatbold" description=""/>
        <symbol table="Y" row="180" id="Yhatitalic" description=""/>
        <symbol table="Y" row="180" id="yhatitalic" description=""/>
        <symbol table="Y" row="185" id="yhatitalicred" description=""/>
        <symbol table="Y" row="190" id="Yhatbolditalic" description=""/>
        <symbol table="Y" row="190" id="yhatbolditalic" description=""/>
        <symbol table="Y" row="195" id="yhatbolditalicred" description=""/>
        <symbol table="Y" row="200" id="Ybar" description=""/>
        <symbol table="Y" row="200" id="ybar" description=""/>
        <symbol table="Y" row="210" id="Ybarbold" description=""/>
        <symbol table="Y" row="210" id="ybarbold" description=""/>
        <symbol table="Y" row="220" id="Ybaritalic" description=""/>
        <symbol table="Y" row="220" id="ybaritalic" description=""/>
        <symbol table="Y" row="230" id="Ybarbolditalic" description=""/>
        <symbol table="Y" row="230" id="ybarbolditalic" description=""/>
        <symbol table="Y" row="240" id="ydblbar" description=""/>
        <symbol table="Y" row="250" id="Yarrow" description=""/>
        <symbol table="Y" row="250" id="yarrow" description=""/>
        <symbol table="Y" row="260" id="Yarrowbold" description=""/>
        <symbol table="Y" row="260" id="yarrowbold" description=""/>
        <symbol table="Y" row="261" id="vecYbold" description=""/>
        <symbol table="Y" row="261" id="vecybold" description=""/>
        <symbol table="Y" row="270" id="Yarrowitalic" description=""/>
        <symbol table="Y" row="270" id="yarrowitalic" description=""/>
        <symbol table="Y" row="280" id="Yarrowbolditalic" description=""/>
        <symbol table="Y" row="280" id="yarrowbolditalic" description=""/>
        <symbol table="Y" row="290" id="Yvec" description=""/>
        <symbol table="Y" row="290" id="yvec" description=""/>
        <symbol table="Y" row="300" id="Yvecbold" description=""/>
        <symbol table="Y" row="300" id="yvecbold" description=""/>
        <symbol table="Y" row="310" id="Yvecitalic" description=""/>
        <symbol table="Y" row="310" id="yvecitalic" description=""/>
        <symbol table="Y" row="320" id="Yvecbolditalic" description=""/>
        <symbol table="Y" row="320" id="yvecbolditalic" description=""/>
        <symbol table="Y" row="340" id="circleY" description=""/>
        <symbol table="Z" row="" id="bbZ" description=""/>
        <symbol table="Z" row="" id="doubleZ" description=""/>
        <symbol table="Z" row="130" id="zdot" description=""/>
        <symbol table="Z" row="140" id="zdbldot" description=""/>
        <symbol table="Z" row="160" id="Zhat" description=""/>
        <symbol table="Z" row="160" id="zhat" description=""/>
        <symbol table="Z" row="170" id="Zhatbold" description=""/>
        <symbol table="Z" row="170" id="zhatbold" description=""/>
        <symbol table="Z" row="180" id="Zhatitalic" description=""/>
        <symbol table="Z" row="180" id="zhatitalic" description=""/>
        <symbol table="Z" row="185" id="zhatitalicred" description=""/>
        <symbol table="Z" row="190" id="Zhatbolditalic" description=""/>
        <symbol table="Z" row="190" id="zhatbolditalic" description=""/>
        <symbol table="Z" row="195" id="zhatbolditalicred" description=""/>
        <symbol table="Z" row="200" id="Zbar" description=""/>
        <symbol table="Z" row="200" id="zbar" description=""/>
        <symbol table="Z" row="210" id="Zbarbold" description=""/>
        <symbol table="Z" row="210" id="zbarbold" description=""/>
        <symbol table="Z" row="220" id="Zbaritalic" description=""/>
        <symbol table="Z" row="220" id="zbaritalic" description=""/>
        <symbol table="Z" row="230" id="Zbarbolditalic" description=""/>
        <symbol table="Z" row="230" id="zbarbolditalic" description=""/>
        <symbol table="Z" row="250" id="Zarrow" description=""/>
        <symbol table="Z" row="250" id="zarrow" description=""/>
        <symbol table="Z" row="260" id="Zarrowbold" description=""/>
        <symbol table="Z" row="260" id="zarrowbold" description=""/>
        <symbol table="Z" row="261" id="vecZbold" description=""/>
        <symbol table="Z" row="261" id="veczbold" description=""/>
        <symbol table="Z" row="270" id="zarrowitalic" description=""/>
        <symbol table="Z" row="280" id="Zarrowbolditalic" description=""/>
        <symbol table="Z" row="280" id="zarrowbolditalic" description=""/>
        <symbol table="Z" row="290" id="Zvec" description=""/>
        <symbol table="Z" row="290" id="zvec" description=""/>
        <symbol table="Z" row="300" id="Zvecbold" description=""/>
        <symbol table="Z" row="300" id="zvecbold" description=""/>
        <symbol table="Z" row="310" id="Zvecitalic" description=""/>
        <symbol table="Z" row="310" id="zvecitalic" description=""/>
        <symbol table="Z" row="320" id="zvecbolditalic" description=""/>
        <symbol table="Z" row="340" id="circleZ" description=""/>
        <symbol table="Zeta" row="100" id="Zeta" description=""/>
        <symbol table="Zeta" row="100" id="Zeta2" description=""/>
        <symbol table="Zeta" row="100" id="Zetabar" description=""/>
        <symbol table="Zeta" row="100" id="Zetadbldot" description=""/>
        <symbol table="Zeta" row="100" id="Zetadot" description=""/>
        <symbol table="Zeta" row="100" id="Zetahat" description=""/>
        <symbol table="Zeta" row="100" id="Zetavec" description=""/>
        <symbol table="Zeta" row="100" id="zeta" description=""/>
        <symbol table="Zeta" row="100" id="zeta2" description=""/>
        <symbol table="Zeta" row="100" id="zetabar" description=""/>
        <symbol table="Zeta" row="100" id="zetadbldot" description=""/>
        <symbol table="Zeta" row="100" id="zetadot" description=""/>
        <symbol table="Zeta" row="100" id="zetahat" description=""/>
        <symbol table="Zeta" row="100" id="zetavec" description=""/>
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
                <li><q>Clean up</q> the downloaded HTML file.<ul>
                    <li>Add the following header:<codeblock>&lt;?xml version="1.0" encoding="UTF-8"?>
&lt;!DOCTYPE html [
&lt;!ENTITY dagger "&amp;#8224;">
&lt;!ENTITY deg "&amp;#176;">
&lt;!ENTITY plusmn "&amp;#177;">
&lt;!ENTITY lsaquo "&amp;#8249;">
&lt;!ENTITY rsaquo "&amp;#8250;">
]></codeblock></li>
                    <li>Change &lt;br> to &lt;br/>.</li>
                </ul></li>
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
        <!-- For use when updating this XSL -->
        <xsl:comment>
        <xsl:for-each select="$knownIDs/symbol">
        <xsl:sort 
            select="concat(normalize-space(@table),replace(concat('000000',normalize-space(@row)),'^0*?(\d{6})$','$1'))"/><xsl:value-of 
            select="concat('&lt;symbol table=&quot;',@table,'&quot; row=&quot;',@row,'&quot; id=&quot;',@id,'&quot; description=&quot;',@description,'&quot;/>')"/>
        </xsl:for-each>
        </xsl:comment>
        <!--  -->
        
        <xsl:for-each-group select="$allsymbols/row" group-by="@table">
            <xsl:sort select="@table"/>
            <section id="{concat('section_',normalize-space(current-grouping-key()))}">
                <title><xsl:value-of 
                    select="normalize-space(replace(current-grouping-key(),'_',' '))"/></title>
                <simpletable id="{concat('simpletable_',normalize-space(current-grouping-key()))}">
                    <sthead><stentry>Symbol</stentry><stentry>Code</stentry></sthead>
                    <xsl:for-each select="current-group()">
            <xsl:sort select="@row" data-type="number"/><xsl:copy-of select="strow"/>
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
                <xsl:when test="$knowndata/@table and string-length($knowndata/@table) > 0"><xsl:value-of select="$knowndata/@table"/></xsl:when>
                <xsl:otherwise>unknown</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="row">
            <xsl:choose>
                <xsl:when test="$knowndata/@row and string-length($knowndata/@row) > 0"><xsl:value-of select="$knowndata/@row"/></xsl:when>
                <xsl:otherwise>9999</xsl:otherwise>
            </xsl:choose>
        </xsl:param>
            <!--<xsl:choose>
                <xsl:when test="$knowndata/@description and string-length($knowndata/@description) > 0"><xsl:value-of select="$knowndata/@description"/></xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>-->
        <xsl:param name="description" select="normalize-space($knowndata/@description)"/>
        
        <row id="{$symbolid}" table="{$table}" row="{$row}">
            <strow id="{$symbolid}">
                <xsl:choose xml:space="default">
                    <xsl:when test="string-length($description) > 0">
                        <stentry>
                            <ph id="{concat($symbolid,'_symbol')}"><i><xsl:value-of select="$description"/></i></ph>
                        </stentry>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="td[2]">
                            <xsl:with-param name="symbolid" select="$symbolid"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
                <stentry>
                    <codeph id="{concat($symbolid,'_code')}">&lt;s:<xsl:value-of select="$symbolid"/>&gt;</codeph>
                    <xsl:comment select="normalize-space($row)"/>
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