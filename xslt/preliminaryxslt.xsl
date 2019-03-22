<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compact"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Processed Poem</title>
                <link rel="stylesheet" type="text/css" href="xslthighlight.css"></link>
            </head>
            <body>
                <!-- First, we get the title of the poem -->
                <h1>
                    <xsl:apply-templates select="/poem/meta/title"/>
                </h1>
                <!-- Now we use apply templates this way to see if there even is a date. That way there's no random empty h2 elements -->
                <xsl:apply-templates select="/poem/meta/date" />
                <xsl:apply-templates select="/poem/stanza" />
            </body>
        </html>
    </xsl:template>
    <xsl:template match="date">
        <h2>
            <xsl:apply-templates/> 
        </h2>
    </xsl:template>
    <xsl:template match="stanza">
        <p>
            <xsl:apply-templates />
        </p>
    </xsl:template>
    <xsl:template match="lb">
        <xsl:if test="count(preceding-sibling::lb) > 0">
            <br/> 
        </xsl:if>
        
    </xsl:template>
    <xsl:template match="noun | verb | adj | adv | ref | prep | conj | inter | pron | foreign| det">
        <span class="{name()} {@value}">
            <xsl:apply-templates />
        </span>
    </xsl:template>
</xsl:stylesheet>