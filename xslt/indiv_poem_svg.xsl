<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <svg height="375">
            <g transform="translate(30, 330)">
                <line x1="20" x2="20" y1="0" y2="-320" stroke="black" stroke-width="2"/>
                <line x1="20" x2="500" y1="0" y2="0" stroke="black" stroke-width="2"/>
                <line x1="20" x2="500" y1="-150" y2="-150" stroke="black" opacity="0.5"
                    stroke-dasharray="8 4" stroke-width="1"/>
                <text x="10" y="5" text-anchor="end">0%</text>
                <text x="10" y="-145" text-anchor="end">50%</text>
                <text x="10" y="-295" text-anchor="end">100%</text>
                <xsl:apply-templates/>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="poem">
        <xsl:variable name="totalWords" select="count(//stanza/*[not(self::lb)])"/>
        <xsl:variable name="openValues" select="count(//stanza/*[@value='open'][not(self::lb)])"/>
        <xsl:variable name="closedValues" select="count(//stanza/*[@value='closed'][not(self::lb)])"/>
           <xsl:variable name="openPercent" select="$openValues div $totalWords"/>
            <xsl:variable name="closedPercent" select="$closedValues div $totalWords"/>
        <rect x="{50}" y="-{$openPercent * 300}" stroke="black" stroke-width="1" fill="blue" width="40" height="{$openPercent * 300}"/>
        <rect x="{115}" y="-{$closedPercent * 300}" stroke="black" stroke-width="1" fill="orange" width="40" height="{$closedPercent * 300}"/>
        <text x="{50}" y="-{$openPercent * 300}" stroke="black">Open</text>
            <text x="{115}" y="-{$closedPercent * 300}" stroke="black">Closed</text>
   
    </xsl:template>
</xsl:stylesheet>