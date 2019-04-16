<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0" xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Processed Poem</title>
                <link rel="stylesheet" type="text/css" href="xslthighlight.css"></link>
            </head>
            <body>
                <p class="backtomarkup"><a href="../Poe_Corpus.xhtml">Back to Table of Contents</a></p>
                <!-- First, we get the title of the poem -->
                <h1>
                    <xsl:apply-templates select="//title"/>
                </h1>
                <div class="legend">
                    <p>Color Codes:</p>
                    <ul>
                        <li><span class="adv">Word</span> - Adverb</li>
                        <li><span class="adj">Word</span> - Adjective</li>
                        <li><span class="noun">Word</span> - Noun</li>
                        <li><span class="verb">Word</span> - Verb</li>
                        <li><span class="prep">Word</span> - Preposition</li>
                        <li><span class="det">Word</span> - Determiner</li>
                        <li><span class="pron">Word</span> - Pronoun</li>
                        <li><span class="conj">Word</span> - Conjunction</li>
                        <li><span class="inter">Word</span> - Interjection</li>
                        <li><span class="ref">Word</span> - Reference</li>
                        <li><span class="foreign">Word</span> - Foreign Word</li>
                    </ul>
                    <p>Emphasis Codes:</p>
                    <ul>
                        <li><span class="open">Word</span> - Postive/Open Term</li>
                        <li><span class="closed">Word</span> - Negative/Closed Term</li>
                    </ul>
                </div>
                <!-- Now we use apply templates this way to see if there even is a date. That way there's no random empty h2 elements -->
                <xsl:apply-templates select="//date" />
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