<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <div class="wrapper-fluid wrapper-navbar sticky-top hide-reading" id="wrapper-navbar">
            <a class="skip-link screen-reader-text sr-only" href="#content">Skip to content</a>
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <div class="nav-title">
                    <a href="index.html" class="navbar-brand custom-logo-link" rel="home" itemprop="url">
                        <p>RECHTSAKTEN <br></br>Karl Kraus</p>
                    </a>
                    </div>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"  data-i18n="navbar__project" ></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="about.html"  data-i18n="navbar__about" ></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="editionsrichtlinien.html"  data-i18n="navbar__richtlinien"></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="team.html"  data-i18n="navbar__team" ></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="publikationen.html"  data-i18n="navbar__publication" ></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="hinweise.html"  data-i18n="navbar__hints" ></a>
                                    </li>
                                   
                                </ul>
                            </li>
                            
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"  data-i18n="navbar__toc" ></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="cases.html"  data-i18n="navbar__cases"></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="toc.html"  data-i18n="navbar__files"></a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown disabled">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"  data-i18n="navbar__register" ></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="listperson.html"  data-i18n="navbar__persons"  ></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listplace.html"  data-i18n="navbar__places" ></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listorg.html"  data-i18n="navbar__orgs" ></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listlegal.html"  data-i18n="navbar__legal" ></a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listbibl.html"  data-i18n="navbar__works" ></a>
                                    </li>
                                </ul>
                            </li>
                            
                            <li class="nav-item">
                                <a title="Suche" class="nav-link" href="search.html"  data-i18n="navbar__search" ></a>
                            </li>
                            <select name="language" id="languageSwitcher"></select>
                        </ul>
                    </div>
                </div>
            </nav>
            
        </div>
    </xsl:template>
</xsl:stylesheet>