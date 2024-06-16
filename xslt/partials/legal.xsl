<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">


    <xsl:template match="tei:bibl" name="legal_detail">
        <dl>
            <dt>Gesetz</dt>
            <dd>
                <xsl:value-of select="./tei:title[@level='s']/text()"/>
            </dd>
            <dt>Titel</dt>
            <dd>
                <xsl:value-of select="./tei:title[@level='a']/text()"/>
            </dd>
            
            
            <xsl:if test="./tei:date">
                <dt>Erscheinungsjahr, -zeitraum</dt>
                <xsl:for-each select="./tei:date">
                    <dd>
                        <xsl:value-of select="normalize-space(./text())"/>
                    </dd>
                </xsl:for-each>
            </xsl:if>
            
        </dl>


    </xsl:template>
</xsl:stylesheet>
