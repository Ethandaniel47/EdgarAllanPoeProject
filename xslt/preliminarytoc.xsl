<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"  media-type="text/html"/>
    
    <xsl:variable name="documents" select="collection('../markedcorpus/?select=*.xml')"/>
    
    <xsl:template name="main">
        <html>
            <head>
                <title>XML Table of Contents</title>
            </head>        
            <body>
                <ul>
                    <xsl:apply-templates select="$documents" />
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="/">
       
    </xsl:template>
    
    <xsl:template match="$documents">
        <xsl:variable name="currdoc" select="tokenize(base-uri(.), '/')[last()]"/>
        
        <li><a href="{tokenize(base-uri(.), '/')[last()]}"><xsl:value-of select="$currdoc"/></a></li>
    </xsl:template>
    
</xsl:stylesheet>