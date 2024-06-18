<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:utils="http://example.com/utils"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map" version="3.0"
    exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"
        omit-xml-declaration="yes"/>
<xsl:variable name="media_translations" as="map(xs:string, xs:string)">
  <xsl:map>
    <xsl:map-entry key="'black-ink'" select="'schwarze Tinte'"/>
    <xsl:map-entry key="'brown-ink'" select="'braune Tinte'"/>
    <xsl:map-entry key="'red-ink'" select="'rote Tinte'"/>
    <xsl:map-entry key="'pencil'" select="'Bleistift'"/>
    <xsl:map-entry key="'grey-pencil'" select="'Bleistift'"/>
    <xsl:map-entry key="'blue-pencil'" select="'blauer Stift'"/>
    <xsl:map-entry key="'red-pencil'" select="'roter Stift'"/>
    <xsl:map-entry key="'green-pencil'" select="'grüner Stift'"/>
  </xsl:map>
</xsl:variable>
<xsl:template name="create-header">
  <xsl:choose>
    <xsl:when test="matches($doc_title,'.*Zeitungsartikel|Aktenvermerk|Originalmappe.*')">
    <div class="col-md-4 mx-auto text-center">
      <xsl:apply-templates select="$teiHeader//tei:creation//tei:date" mode="correspondence"/>
      <div>
        <xsl:if test="$teiHeader//tei:stamp"><br/>
          <xsl:apply-templates select="$teiHeader//tei:stamp" mode="correspondence"/>
        </xsl:if>
      </div>
    </div>
    </xsl:when>
    <xsl:when test="matches($doc_title,'.*Brief.*')">
      <div class="col-4">
        <xsl:apply-templates select="$teiHeader//tei:ab[@type='materiality']"/>
        <xsl:call-template name="handnotes"/>
      </div>
      <div class="col-4">
        <xsl:apply-templates select="$teiHeader//tei:correspAction[@type='sent']"/>
      </div>
      <div class="col-4">
        <xsl:apply-templates select="$teiHeader//tei:correspAction[@type='received']"/>
        <xsl:if test="$teiHeader//tei:stamp">
          <xsl:apply-templates select="$teiHeader//tei:stamp" mode="correspondence"/>
        </xsl:if>
      </div>
    </xsl:when>
    <xsl:otherwise>
    <div class="col-md-4">
      <xsl:call-template name="handnotes"/>
    </div>
    <div class="col-md-4">
        <xsl:apply-templates select="$teiHeader//tei:ab[@type='materiality']"/>
        <xsl:apply-templates select="$teiHeader//tei:creation//tei:date" mode="correspondence"/>
         <xsl:if test="$teiHeader//tei:stamp">
         <div>
            <xsl:apply-templates select="$teiHeader//tei:stamp" mode="correspondence"/>
        </div>
        </xsl:if>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="tei:ab[@type='materiality']">
  <div>
    <p class="mb-0 fw-bold">Materialitätstyp:</p>
    <ul class="list-unstyled">
      <xsl:for-each select="tei:objectType">
        <li><xsl:value-of select="current()"/></li>
      </xsl:for-each>
    </ul>
  </div>
</xsl:template>
<xsl:template match="tei:correspAction[@type=('sent','received')]">
<xsl:variable name="type" select="@type"/>
  <div>
    <p class="mb-0 fw-bold">
      <xsl:choose>
        <xsl:when test="$type='sent'">
          <xsl:text>Sender</xsl:text>
        </xsl:when>
        <xsl:when test="$type='received'">
          <xsl:text>Empfänger</xsl:text>
        </xsl:when>
      </xsl:choose>
    </p>
    <address class="mb-0">
      <xsl:apply-templates select="tei:persName|tei:orgName" mode="correspondence">
        <xsl:with-param name="is_receiver" select="boolean($type='received')"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="tei:address/tei:street" mode="correspondence"/>
      <xsl:apply-templates select="tei:address/tei:settlement" mode="correspondence"/>
    </address>
    <xsl:apply-templates select="tei:date" mode="correspondence"/>
    <xsl:if test="$type='sent'">
      <xsl:if test="//tei:note[@type='subject']/text()">
        <div>
          <xsl:value-of select="'Betreff: '||//tei:note[@type='subject']"/>
        </div>
      </xsl:if>
      <xsl:if test="//tei:note[@type='dictation']/text()">
        <div>
          <xsl:value-of select="'Diktiersigle: '||//tei:note[@type='dictation']"/>
        </div>
      </xsl:if>
    </xsl:if>
  </div>
</xsl:template>
<xsl:template match="tei:publicationStmt"/>
<xsl:template match="tei:titleStmt"/>
<xsl:template match="tei:seriesStmt"/>
<xsl:template match="tei:persName[text()]"  mode="correspondence">
  <xsl:param name="is_receiver"/>
    <span>
    <xsl:if test="$is_receiver">
      <xsl:text>An: </xsl:text>
    </xsl:if>
      <xsl:value-of select="text()"/>
    </span><br/>
</xsl:template>
<xsl:template match="tei:persName[not(text())]"  mode="correspondence">
  <xsl:param name="is_receiver"/>
  <xsl:variable name="ref" select="@ref"/>
  <xsl:variable name="person" select="root()//tei:person[@xml:id=substring-after($ref,'#')]"/>
    <xsl:if test="$person">
    <span>
    <xsl:if test="$is_receiver">
      <xsl:text>An: </xsl:text>
    </xsl:if>
      <xsl:value-of select="$person/tei:persName/tei:forename||' '||$person/tei:persName/tei:surname"/>
    </span><br/>
    </xsl:if>
</xsl:template>
<xsl:template match="tei:orgName[text()]"  mode="correspondence">
  <xsl:param name="is_receiver"/>
    <span>
    <xsl:if test="$is_receiver">
      <xsl:text>An: </xsl:text>
    </xsl:if>
      <xsl:value-of select="text()"/>
    </span><br/>
</xsl:template>
<xsl:template match="tei:orgName[not(text())]"  mode="correspondence">
  <xsl:param name="is_receiver"/>
  <xsl:variable name="ref" select="@ref"/>
  <xsl:variable name="org" select="root()//tei:org[@xml:id=substring-after($ref,'#')]"/>
    <xsl:if test="$org">
    <span>
    <xsl:if test="$is_receiver">
      <xsl:text>An: </xsl:text>
    </xsl:if>
      <xsl:value-of select="head($org/tei:orgName)"/>
    </span><br/>
    </xsl:if>
</xsl:template>
<xsl:template match="tei:street[text()]"  mode="correspondence">
  <xsl:value-of select="text()"/><br/>
</xsl:template>
<xsl:template match="tei:street[not(text())]"  mode="correspondence">
  <xsl:variable name="ref" select="@corresp"/>
  <xsl:variable name="street" select="root()//tei:place[@xml:id=substring-after($ref,'#')]"/>
    <xsl:if test="$street">
    <span>
      <xsl:value-of select="head($street//tei:placeName)"/>
    </span><br/>
    </xsl:if>
</xsl:template>
<xsl:template match="tei:settlement[text()]"  mode="correspondence">
  <xsl:value-of select="text()"/>
</xsl:template>
<xsl:template match="tei:settlement[not(text())]"  mode="correspondence">
  <xsl:variable name="ref" select="@ref"/>
  <xsl:variable name="place" select="root()//tei:place[@xml:id=substring-after($ref,'#')]"/>
    <xsl:if test="$place">
    <span>
      <xsl:value-of select="head($place//tei:placeName)"/>
    </span><br/>
    </xsl:if>
</xsl:template>
<!-- need a named template because of incoherent data -->
<xsl:template name="handnotes">
<xsl:if test="//tei:handNote">
  <div>
    <p class="mb-0 fw-bold">Schreiberhände:</p>
    <ul class="list-unstyled">
      <xsl:apply-templates select="//tei:handNote"/>
    </ul>
  </div>
</xsl:if>
</xsl:template>
<xsl:template match="tei:handNote">
  <xsl:variable name="ref" select="@scribeRef"/>
  <xsl:variable name="medium" select="map:get($media_translations,@medium)"/>
  <xsl:variable name="person" select="root()//tei:person[@xml:id=substring-after($ref,'#')]"/>
  <li>
    <xsl:if test="$person">
      <xsl:value-of select="head($person//tei:persName)/tei:forename||' '||head($person//tei:persName)/tei:surname||', '"/>
    </xsl:if>
    <xsl:value-of select="$medium"/>
  </li>
</xsl:template>
<xsl:template match="tei:stamp"  mode="correspondence">
  <xsl:variable name="ref" select="@source"/>
  <xsl:variable name="org" select="root()//tei:org[@xml:id=substring-after($ref,'#')]"/>
    <xsl:if test="$org">
    <span>
      <xsl:value-of select="'Stempel: '||head($org/tei:orgName)"/>
    </span><br/>
  </xsl:if>
</xsl:template>
<xsl:template match="tei:date[text()]" mode="correspondence">
<xsl:if test=".">
  <div>
    <span>Datum: <xsl:value-of select="."/></span>
  </div>
</xsl:if>
</xsl:template>
</xsl:stylesheet>