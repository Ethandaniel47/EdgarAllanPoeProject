<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0" xmlns="http://www.w3.org/2000/svg">
    <!--To run this from the command line - invoke java  -jar <insertpathto saxon9he.jar>  -xsl:svgposorneg.xsl -it:main -o:Transformations/testsvg.svg -->
    
    
    <xsl:variable name="documents" select="collection('../markedcorpus/?select=*.xml')"/>
    <xsl:variable name="xscale" select="3"/>
    <xsl:variable name="xwidth" select="(300 * $xscale) + 3"/>
    <xsl:variable name="bar-height" select="12"/>
    <xsl:variable name="ylength" select="count($documents) * $bar-height"/>
    <xsl:variable name="translatey" select="50 + $ylength"/>
    <xsl:variable name="axisstroke" select="2"/>
    <xsl:template name="main">
        <svg>
            <g transform="translate(100,{$translatey})">
                <!-- Axis lines for the bar graph -->
                <line x1="0" y1="-{$ylength + $axisstroke}" x2="{$xwidth}" y2="-{$ylength + 2}" stroke="black" stroke-width="{$axisstroke}"/>
                <line x1="0" y1="-{$ylength + $axisstroke}" x2="0" y2="0" stroke="black" stroke-width="{$axisstroke}"/>
                <line x1="{$xwidth}" y1="-{$ylength + $axisstroke}" x2="{$xwidth}" y2="0" stroke="black" stroke-width="{$axisstroke}"/>
                <line x1="0" y1="0" x2="{$xwidth}" y2="0" stroke="black" stroke-width="{$axisstroke}"/>
                <line x1="{$xwidth div 2}" y1="-{$ylength + $axisstroke}" x2="{$xwidth div 2}" y2="0" stroke="black" stroke-width="{$axisstroke}"/>
                <!-- Legend -->
                <rect x="{$xwidth + 40}" y="-{$ylength * (2 div 3)}" height="20" width="20" fill="green" stroke="black"/>
                <text x="{$xwidth + 65}" y="-{$ylength * (2 div 3) - 15}" text-anchor="start" fill="black"> - Positive</text>
                <rect x="{$xwidth + 40}" y="-{$ylength * (2 div 3) - 30}" height="20" width="20" fill="red" stroke="black"/>
                <text x="{$xwidth + 65}" y="-{$ylength * (2 div 3) - 45}" text-anchor="start" fill="black"> - Negative</text>
                
                <!-- Now for the text -->
                <!-- Title -->
                <text x="{$xwidth div 2}" y="-{$ylength + 25}" font-weight="bold" font-size="24" text-anchor="middle" fill="black">Total Positive vs. Negative Values</text>
                <!-- Axis Numbers-->
                <text x="{$xwidth}" y="-{$ylength + 10}" font-weight="bold" font-size="16" text-anchor="middle" fill="black">150</text>
                <text x="{0}" y="-{$ylength + 10}" font-weight="bold" font-size="16" text-anchor="middle" fill="black">150</text>
                <text x="{$xwidth div 2}" y="-{$ylength + 5}" font-weight="bold" font-size="16" text-anchor="middle" fill="black">0</text>
                <!-- Now to draw the bars for our visualization -->
                
                <xsl:apply-templates select="$documents"/>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="/">
        
    </xsl:template>
    
    <xsl:template match="$documents">
        <!-- Variables for cleaner documentation -->
        <xsl:variable name="currdoc" select="tokenize(tokenize(base-uri(.), '/')[last()], '\.')[1]"/>
        <!-- Thankfully position tells us the element number in the collection, so we can use that to our advantage -->
        <xsl:variable name="prevdocs" select="position()"/>
        <xsl:variable name="open" select=".//*[@value='open']"/>
        <xsl:variable name="closed" select=".//*[@value='closed']"/>
        <xsl:variable name="posx" select="($xwidth div 2) - count($open)*$xscale"/>
        <xsl:variable name="barY" select="$ylength + 1 - (($prevdocs - 1) * $bar-height)"/>
        
        <rect x="{$posx}" y="-{$barY}" width="{count($open) * $xscale}" height="{$bar-height}" fill="green" stroke="black"/>
        <rect x="{($xwidth div 2)}" y="-{$barY}" width="{count($closed) * $xscale}" height="{$bar-height}" fill="red" stroke="black"/>
        <text x="{$posx - 5}" y="-{$barY - 10}" text-anchor="end" font-size="12"><xsl:value-of select="//title"/></text>
    </xsl:template>
    
</xsl:stylesheet>