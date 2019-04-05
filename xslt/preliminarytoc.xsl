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
                <link rel="stylesheet" type="text/css" href="xslthighlight.css"></link>
            </head>        
            <body>
                <h1>Markup Table of Contents</h1>
                <ul>
                    <xsl:apply-templates select="$documents" />
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="/">
       
    </xsl:template>
    
    <xsl:template match="$documents">
        <xsl:variable name="currdoc" select="tokenize(tokenize(base-uri(.), '/')[last()], '\.')[1]"/>
        
        <li><a href="{$currdoc}.xhtml"><xsl:apply-templates select=".//title"/></a></li>
    </xsl:template>
    
</xsl:stylesheet>