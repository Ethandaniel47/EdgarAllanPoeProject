<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0" xmlns="http://www.w3.org/2000/svg">
    
    <!-- command line - java  -jar <insertpathto saxon9he.jar> -xsl:svgpos.xsl -it:main -o:SVG\partossvg.svg -->
    
    <xsl:variable name="documents" select="collection('../markedcorpus/?select=*.xml')"/>
    <xsl:variable name="xscale" select="3"/>
    <xsl:variable name="xwidth" select="(200 * $xscale) + 3"/>
    <xsl:variable name="ylength" select="600 * $yscale"/>
    <xsl:variable name="yscale" select="1"/>
    <xsl:variable name="translatey" select="40 + $ylength"/>
    <xsl:variable name="axisstroke" select="2"/>
    <xsl:variable name="bar-width" select="10 * $xscale"/>    
    <xsl:variable name="bar-gap" select="20 * $xscale"/>
    
    <xsl:variable name="advopen" select="count($documents//adv[@value='open'])"/>
    <xsl:variable name="advclosed" select="count($documents//adv[@value='closed'])"/>
    <xsl:variable name="adjopen" select="count($documents//adj[@value='open'])"/>
    <xsl:variable name="adjclosed" select="count($documents//adj[@value='closed'])"/>
    <xsl:variable name="verbopen" select="count($documents//verb[@value='open'])"/>
    <xsl:variable name="verbclosed" select="count($documents//verb[@value='closed'])"/>
    <xsl:variable name="nounopen" select="count($documents//noun[@value='open'])"/>
    <xsl:variable name="nounclosed" select="count($documents//noun[@value='closed'])"/>
    <xsl:variable name="prepopen" select="count($documents//prep[@value='open'])"/>
    <xsl:variable name="prepclosed" select="count($documents//prep[@value='closed'])"/>
    <xsl:variable name="detopen" select="count($documents//det[@value='open'])"/>
    <xsl:variable name="detclosed" select="count($documents//det[@value='closed'])"/>
    <xsl:variable name="conjopen" select="count($documents//conj[@value='open'])"/>
    <xsl:variable name="conjclosed" select="count($documents//conj[@value='closed'])"/>
    <xsl:variable name="pronopen" select="count($documents//pron[@value='open'])"/>
    <xsl:variable name="pronclosed" select="count($documents//pron[@value='closed'])"/>
    <xsl:variable name="interopen" select="count($documents//inter[@value='open'])"/>
    <xsl:variable name="interclosed" select="count($documents//inter[@value='closed'])"/>
    
    <xsl:template name="main">
        <svg>
            <g transform="translate(100,{$translatey})">
                <!-- Axis lines for the bar graph -->
                <!--<line x1="0" y1="-{$ylength + $axisstroke}" x2="{$xwidth}" y2="-{$ylength + 2}" stroke="black" stroke-width="{$axisstroke}"/>-->
                <line x1="0" y1="-{$ylength + $axisstroke}" x2="0" y2="0" stroke="black" stroke-width="{$axisstroke}"/>
                <!--<line x1="{$xwidth}" y1="-{$ylength + $axisstroke}" x2="{$xwidth}" y2="0" stroke="black" stroke-width="{$axisstroke}"/>-->
                <line x1="0" y1="0" x2="{$xwidth}" y2="0" stroke="black" stroke-width="{$axisstroke}"/>
                <!--<line x1="{$xwidth div 2}" y1="-{$ylength + $axisstroke}" x2="{$xwidth div 2}" y2="0" stroke="black" stroke-width="{$axisstroke}"/>-->
                <!-- Legend -->
                <rect x="{$xwidth + 40}" y="-{$ylength * (2 div 3)}" height="20" width="20" fill="blue" stroke="black"/>
                <text x="{$xwidth + 65}" y="-{$ylength * (2 div 3) - 15}" text-anchor="start" fill="black"> - Open</text>
                <rect x="{$xwidth + 40}" y="-{$ylength * (2 div 3) - 30}" height="20" width="20" fill="orange" stroke="black"/>
                <text x="{$xwidth + 65}" y="-{$ylength * (2 div 3) - 45}" text-anchor="start" fill="black"> - Closed</text>
                
                <!-- Now for the text -->
                <!-- Title -->
                <text x="{$xwidth div 2}" y="-{$ylength + 15}" font-weight="bold" font-size="24" text-anchor="middle" fill="black">Open vs. Closed on Parts of Speech</text>
                <!-- Axis Numbers-->
                <!-- <text x="{$xwidth}" y="-{$ylength + 10}" font-weight="bold" font-size="16" text-anchor="middle" fill="black">150</text>-->
                <text x="-25" y="-{$ylength}" font-weight="bold" font-size="16" text-anchor="middle" fill="black">600</text>
                <text x="-25" y="-{$ylength - 155}" font-weight="bold" font-size="16" text-anchor="middle" fill="black">450</text>
                <text x="-25" y="-{$ylength div 2 - 5}" font-weight="bold" font-size="16" text-anchor="middle" fill="black">300</text>
                <text x="-25" y="-{$ylength div 4 - 5}" font-weight="bold" font-size="16" text-anchor="middle" fill="black">150</text>
                <text x="-15" y="12" font-weight="bold" font-size="16" text-anchor="middle" fill="black">0</text>
                <!-- Axis lines -->
                <line x1="-10" y1="-{$ylength - 150}" x2="10" y2="-{$ylength - 150}" stroke="black" stroke-width="{$axisstroke}"/>
                <line x1="-10" y1="-{$ylength div 2}" x2="10" y2="-{$ylength div 2}" stroke="black" stroke-width="{$axisstroke}"/>
                <line x1="-10" y1="-{$ylength div 4}" x2="10" y2="-{$ylength div 4}" stroke="black" stroke-width="{$axisstroke}"/>
                <!-- Now to draw the bars for our visualization -->
                <xsl:call-template name="rectanglesummoner"/>
                
            </g>
        </svg>
    </xsl:template>
    <xsl:template name="rectanglesummoner">
        <!-- Adverbs -->
        <xsl:call-template name="drawrectangles">
            <xsl:with-param name="open" select="$advopen"/>
            <xsl:with-param name="closed" select="$advclosed"/>
            <xsl:with-param name="barnum" select="1"></xsl:with-param>
            <xsl:with-param name="barname" select="'Adverb'"></xsl:with-param>
        </xsl:call-template>
        <!-- Adjectives -->
        <xsl:call-template name="drawrectangles">
            <xsl:with-param name="open" select="$adjopen"/>
            <xsl:with-param name="closed" select="$adjclosed"/>
            <xsl:with-param name="barnum" select="2"></xsl:with-param>
            <xsl:with-param name="barname" select="'Adjective'"></xsl:with-param>
        </xsl:call-template>
        <!-- Verb -->
        <xsl:call-template name="drawrectangles">
            <xsl:with-param name="open" select="$verbopen"/>
            <xsl:with-param name="closed" select="$verbclosed"/>
            <xsl:with-param name="barnum" select="3"></xsl:with-param>
            <xsl:with-param name="barname" select="'Verb'"></xsl:with-param>
        </xsl:call-template>
        <!-- Nouns -->
        <xsl:call-template name="drawrectangles">
            <xsl:with-param name="open" select="$nounopen"/>
            <xsl:with-param name="closed" select="$nounclosed"/>
            <xsl:with-param name="barnum" select="4"></xsl:with-param>
            <xsl:with-param name="barname" select="'Noun'"></xsl:with-param>
        </xsl:call-template>
        <!-- Prepositions -->
        <xsl:call-template name="drawrectangles">
            <xsl:with-param name="open" select="$prepopen"/>
            <xsl:with-param name="closed" select="$prepclosed"/>
            <xsl:with-param name="barnum" select="5"></xsl:with-param>
            <xsl:with-param name="barname" select="'Preposition'"></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="drawrectangles">
        <xsl:param name="open"/>
        <xsl:param name="closed"/>
        <xsl:param name="barnum"/>
        
        <xsl:param name="barname"/>
        <xsl:variable name="rectx" select="($bar-gap * $barnum + $bar-width * ($barnum - 1))"/>
        <!-- The Rectangle Formula-->
        <rect x="{$rectx}" y="-{$open * $yscale}" width="{$bar-width}" height="{$open * $yscale}" stroke="black" fill="blue"/>
        <rect x="{$rectx}" y="-{$open * $yscale + ($closed * $yscale)}" width="{$bar-width}" height="{$closed * $yscale}" stroke="black" fill="orange"/>
        <text x="{$rectx + 15}" y="15" text-anchor="middle"><xsl:value-of select="$barname"/></text>
        <!-- If you need to see the exact values of each part of speech - uncomment out these two lines here and re-run the transformation -->
        <!--<text x="{$rectx + 15}" y="-400" text-anchor="middle" fill="green"><xsl:value-of select="$open"/></text>
        <text x="{$rectx + 15}" y="-385" text-anchor="middle" fill="red"><xsl:value-of select="$closed"/></text>-->
    </xsl:template>
    
</xsl:stylesheet>
<!-- Legacy Code -->
<!-- <rect x="{$bar-gap}" y="-{$advopen * $yscale}" width="{$bar-width}" height="{$advopen * $yscale}" stroke="black" fill="green"/>-->
<!--<rect x="{$bar-gap}" y="-{$advopen * $yscale + ($advclosed * $yscale)}" width="{$bar-width}" height="{$advclosed * $yscale}" stroke="black" fill="red"/>-->
<!-- Adj Rectangle -->
<!--<rect x="{($bar-gap * 2 + $bar-width)}" y="-{$adjopen * $yscale}" width="{$bar-width}" height="{$adjopen * $yscale}" stroke="black" fill="green"/>
        <rect x="{($bar-gap * 2 + $bar-width)}" y="-{$adjopen * $yscale + ($adjclosed * $yscale)}" width="{$bar-width}" height="{$adjclosed * $yscale}" stroke="black" fill="red"/>-->
<!-- Verb Rectangles -->
<!--<rect x="{($bar-gap * 3 + $bar-width * 2)}" y="-{$verbopen * $yscale}" width="{$bar-width}" height="{$verbopen * $yscale}" stroke="black" fill="green"/>
        <rect x="{($bar-gap * 3 + $bar-width * 2)}" y="-{$verbopen * $yscale + ($verbclosed * $yscale)}" width="{$bar-width}" height="{$verbclosed * $yscale}" stroke="black" fill="red"/>-->
<!-- Noun Rectangles -->