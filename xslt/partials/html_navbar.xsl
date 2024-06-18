<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <div class="wrapper-fluid wrapper-navbar sticky-top hide-reading" id="wrapper-navbar">
            <a class="skip-link screen-reader-text sr-only" href="#content">Skip to content</a>
            <nav class="navbar navbar-expand-lg bg-white border-bottom border-primary border-3">
                <div class="container-fluid">
                    <a href="index.html" class="navbar-brand custom-logo-link" rel="home" itemprop="url">
                   <img src="images/rechtsakten_karl_kraus_logo.svg" width="160" height="auto"/>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Projekt</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="about.html">Projektinformation</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="editionsrichtlinien.html">Editionsrichtlinien</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="team.html">Projektteam</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="publikationen.html">Publikationen</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="hinweise.html">Benutzungshinweise</a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider" />
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="https://github.com/karl-kraus/legalkraus-static">Code Repo zur Applikation</a>
                                    </li>
                                   
                                </ul>
                            </li>
                            
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Akten-Edition</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="kultur.html">Kultur</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="politik.html">Politik</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item disabled" href="recht.html">Recht</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="cases.html">Alle Akten</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="toc.html">Alle Dokumente</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown disabled">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Visualisierungen</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="fallstatistik.html">Fallstatistik</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="zeitstrahl.html">Zeitstrahl</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown disabled">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Register</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="listperson.html">Personen</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listplace.html">Orte</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listorg.html">Institutionen</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listbibl.html">Werke</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listlegal.html">Juristische Texte</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listfackel.html">Fackel</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown disabled">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Handapparat</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="boehm.html">Hermann Böhm: „Karl Kraus contra …“</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="beitraege.html">Beiträge</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="oskar-samek.html">Oskar Samek</a>
                                    </li>
                                </ul>
                            </li>
                            
                            <li class="nav-item">
                                <a title="Suche" class="nav-link" href="search.html">Suche</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            
        </div>
    </xsl:template>
</xsl:stylesheet>