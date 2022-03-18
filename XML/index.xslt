<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<head>
			<meta charset="UTF-8" />
			<title>Farby</title>
			<meta name="viewport" content="width=device-width, initial-scale=1.0" />
			<link rel="stylesheet" href="XML.css" />
		</head>
		<body>
		<div class="container">
			<h1 class="head"><xsl:value-of select="usługa_dla_sklepu/dostawa/komentarz"/></h1>
			<main>
			<h2 class="head"> Informacje dotyczące odbioru: </h2>
			<p>Godzina: <xsl:apply-templates select="usługa_dla_sklepu/odbiór_formalnośći"/></p>
			<p>Ilość towaru na paletach: <xsl:number value="25000" grouping-separator="." grouping-size="3"/>,</p>
			<p>Zapełnienie magazynu: <xsl:value-of select='format-number(0.87456, "#%")' />,</p>
			<p>Poziom zapełnienia tirów: <xsl:value-of select='format-number(0.95456, "#%")' />,</p>
			<p>Współprace z firmami: <xsl:value-of select="$ile_firm"/></p>
			<p>Kod dostawy: <xsl:value-of select="$Kod"/></p>
			<xsl:call-template name="odpowiedzialni_za_odbiór"/>
			<xsl:call-template name="odpowiedzialni_za_rozładunek"/>
			<xsl:apply-templates select="usługa_dla_sklepu/odbiór_formalnośći/przekierowania_do_sklepów/link"/>
			<h3 class="head">Informacja dla kuriera:</h3>
			<xsl:apply-templates select="usługa_dla_sklepu/odbiór_formalnośći/informacja_dla_dostawcy"/>
			</main>
			
			
			<div id="gallery">
			<p>Typ obrazów: <xsl:value-of select="usługa_dla_sklepu/dostawa/obrazy/@typ"/></p>
			<xsl:apply-templates select="usługa_dla_sklepu/dostawa/obrazy/image"/>
			</div>
			<div id="table"><xsl:apply-templates select="usługa_dla_sklepu/dostawa/farby/Typ"/></div>
			</div>
		</body>
	</xsl:template>
	
	<xsl:variable name="ile_firm" select="'3'" />
	
	<xsl:variable name="Kod" >
		<I>10.</I>
		<II>34.</II>
		<III>56.</III>
		<IV>23.</IV>
		<V>15.</V>
		<VI>67.</VI>
	</xsl:variable>
	
	<xsl:template match="dostawa/odbiór_formalnośći/informacja_dla_dostawcy">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template match="dostawa/farby/Typ">
		<table border="1" id="tb">
			<tr>
				<tr>
					<th colspan="3" id="up">Dane o dostawie</th>
				</tr>
				<tr>
					<th colspan="3">Farby</th> 
				</tr>
				<tr>
					<th>Rodzaj</th> 
					<th>Firma</th> 
					<th>Dane</th>
				</tr>
			</tr>
			<xsl:if test="@rodzaj ='akwarele'">
				<td rowspan="16"><xsl:value-of select="@rodzaj" /> </td>
				<xsl:apply-templates select="Dostawca"/>
			</xsl:if >
			<xsl:if test="@rodzaj ='gwasz'">
				<td rowspan="16"><xsl:value-of select="@rodzaj" /> </td>
				<xsl:apply-templates select="Dostawca"/>
			</xsl:if >
			<xsl:if test="@rodzaj ='akryl'">
				<td rowspan="16"><xsl:value-of select="@rodzaj" /> </td>
				<xsl:apply-templates select="Dostawca"/>
			</xsl:if >
			<xsl:if test="@rodzaj ='olejne'">
				<td rowspan="16"><xsl:value-of select="@rodzaj" /> </td>
				<xsl:apply-templates select="Dostawca"/>
			</xsl:if >
		</table>
	</xsl:template>
	
	<xsl:template match="dostawa/farby/Typ/Dostawca">
		<tr>
			<td rowspan="5"><xsl:value-of select="@firma" /> </td>
			<td><xsl:value-of select="Cena_zakupu"/></td>
		</tr>
		<tr>
			<td><xsl:value-of select="Cena_sprzedarzy"/></td>
		</tr>
		<tr>
			<td><xsl:value-of select="Ilość_towaru"/></td>
		</tr>
		<tr>
			<td><xsl:value-of select="Pojemnosc_Towaru"/></td>
		</tr>
		<tr>
			<td><xsl:value-of select="Ocena_towaru"/></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="dostawa/obrazy/image">
		<img height="100" width="200">
			<xsl:attribute name="src">
				<xsl:value-of select="@source"/>
			</xsl:attribute>
			<xsl:attribute name="class">
				left
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:value-of select="."/>
			</xsl:attribute>
		</img>
	</xsl:template>
	
	<xsl:template name="odpowiedzialni_za_odbiór">
		<ul>
			<xsl:for-each select="usługa_dla_sklepu/odbiór_formalnośći/odpowiedzialni_za_odbiór/Pracownik" >
				<xsl:sort select="."/>
					<li><xsl:number format="1. "/><xsl:value-of select="."/></li>
			</xsl:for-each>
		</ul>	
	</xsl:template>
	
	<xsl:template match="odbiór_formalnośći/przekierowania_do_sklepów/link">
		<xsl:if test="not(position() = last())">
			<li>
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="@source"/>
					</xsl:attribute>
					<xsl:value-of select="."/>
				</a>
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="odpowiedzialni_za_rozładunek">
		<ul>
			<xsl:for-each select="usługa_dla_sklepu/odbiór_formalnośći/odpowiedzialni_za_rozładunek/Pracownik" >
					<li><xsl:number format="1. "/><xsl:value-of select="."/>  </li>
			</xsl:for-each>
		</ul>	
	</xsl:template>
	
	<xsl:template match="odbiór_formalnośći">
		<xsl:value-of select="@godzina"/>
	</xsl:template>
	
</xsl:stylesheet>