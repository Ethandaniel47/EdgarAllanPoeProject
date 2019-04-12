<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0" xmlns="http://www.w3.org/2000/svg">    
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <svg>
            <g transform="translate(80,400)">
                <line x1="0" y1="0" x2="300" y2="0" stroke="black" stroke-width="1" stroke-linecap="square"/>
                <line x1="0" y1="0" x2="0" y2="-300" stroke="black" stroke-width="1"/>
                <xsl:apply-templates select="//candidate[@party='Democrat']"/>
            </g>
        </svg>
    </xsl:template>   
</xsl:stylesheet>