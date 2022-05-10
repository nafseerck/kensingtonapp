import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/pages/dashboard/Dashboard_page.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/DialogUtil.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:kensington/utils/custom_widgets.dart';
import 'package:mailto/mailto.dart';
import 'package:provider/provider.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class ImprintPage extends StatefulWidget {
  String langcode;
  ImprintPage({Key key, this.langcode}) : super(key: key);

  @override
  _RequestSendState createState() => _RequestSendState();
}

const htmlData = """
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Website operator:</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'><span style="box-sizing: border-box;">KENSINGTON Finest Properties International AG</span><br style="box-sizing: border-box;">Konstanzerstrasse 37<br style="box-sizing: border-box;">8274 T&auml;gerwilen<br style="box-sizing: border-box;">Schweiz<br style="box-sizing: border-box;">Phone: +41 71 54 49 700<br style="box-sizing: border-box;">Mail: <a href="mailto:muhammed.ashar@kensington-international.com" style="box-sizing: border-box; color: rgb(29, 97, 80); text-decoration: none; text-decoration-skip: objects; transition: all 0.2s ease-in-out; margin-bottom: 0px;">muhammed.ashar@kensington-international.com</a></p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Director: Mehrdad Bonakdar<br style="box-sizing: border-box; margin-bottom: 0px;">Company number: CH-440.3.026.388-8</p>
<h2 class="text-primary mt-5 mb-3" style='box-sizing: border-box; margin-bottom: 0.5rem; font-family: "PT Serif", serif; font-weight: 500; line-height: 1.2; font-size: 1.75rem; margin-right: 0px; margin-left: 0px; margin-top: 3rem !important; color: rgb(29, 97, 80) !important;'>Disclaimer</h2>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>None of the information and data presented on this website may be copied, downloaded or used for other purposes without the express written permission of the owner.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Any unlawful acts will entail prosecution.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>KENSINGTON Finest Properties International AG assumes no liability for the current relevance, completeness or correctness of the information provided. KENSINGTON Finest Properties International AG reserves the right to modify current contents.<br style="box-sizing: border-box; margin-bottom: 0px;">E-mails received via this website will be kept strictly confidential. Your e-mail address will be used for internal purposes only and will not be transferred, sold or leased out to third parties.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>All property contents, photos and property details are supplied by the franchisees of KENSINGTON Finest Properties International AG and no guarantee can be assumed by the operator of this website in this respect.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>All information on this website is provided without any guarantee.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>All rights reserved.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 0px; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'><em style="box-sizing: border-box; margin-bottom: 0px;">The EU Commission has set up an online platform for the resolution of disputes (&ldquo;OS Platform&rdquo;) between businesses and consumers. The OS Platform can be reached at <a href="https://ec.europa.eu/consumers/odr/" style="box-sizing: border-box; color: rgb(29, 97, 80); text-decoration: none; text-decoration-skip: objects; transition: all 0.2s ease-in-out; margin-bottom: 0px;">https://ec.europa.eu/consumers/odr/</a>.</em></p>
""";
const htmlDatagerman = """
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Inhaber der Domain und Betreiber dieser Website:</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'><span style="box-sizing: border-box;">Kensington Finest Properties International AG</span><br style="box-sizing: border-box;">Konstanzerstrasse 37<br style="box-sizing: border-box;">8274 T&auml;gerwilen<br style="box-sizing: border-box;">Schweiz<br style="box-sizing: border-box;">Phone: +41 71 54 49 700<br style="box-sizing: border-box;">Mail: <a href="mailto:muhammed.ashar@kensington-international.com" style="box-sizing: border-box; color: rgb(29, 97, 80); text-decoration: none; text-decoration-skip: objects; transition: all 0.2s ease-in-out; margin-bottom: 0px;">muhammed.ashar@kensington-international.com</a></p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Verwaltungsrat: Mehrdad Bonakdar<br style="box-sizing: border-box; margin-bottom: 0px;">Handelsregisternummer: CH-440.3.026.388-8</p>
<h3 class="text-primary mt-5 mb-3" style='box-sizing: border-box; margin-bottom: 0.5rem; font-family: "PT Serif", serif; font-weight: 500; line-height: 1.2; font-size: 1.53125rem; margin-right: 0px; margin-left: 0px; margin-top: 3rem !important; color: rgb(29, 97, 80) !important;'>Haftungshinweis</h3>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Alle auf dieser Website enthaltenen Informationen und Daten d&uuml;rfen ohne die ausdr&uuml;ckliche schriftliche Genehmigung des Betreibers weder kopiert, noch heruntergeladen, noch zu anderen Zwecken verwendet werden.<br style="box-sizing: border-box; margin-bottom: 0px;">Widerrechtliche Handlungen werden strafrechtlich verfolgt.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Kensington Finest Properties International AG &uuml;bernimmt keinerlei Haftung f&uuml;r Aktualit&auml;t, Vollst&auml;ndigkeit oder Korrektheit der bereitgestellten Informationen. Kensington Finest Properties International AG beh&auml;lt sich das Recht vor, laufende Inhalte zu &auml;ndern.<br style="box-sizing: border-box; margin-bottom: 0px;">E-Mails die &uuml;ber diese Website eingehen werden streng vertraulich behandelt. Ihre E-Mail-Adresse dient nur der internen Verwendung und wird nicht an Dritte weitergegeben, verkauft oder vermietet.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Die Inhalte, Fotos und alle Objektinformationen, werden von den Franchisenehmern der KENSINGTON Finest Properties International AG geliefert, f&uuml;r die keine Gew&auml;hr vom Betreiber dieser Seite &uuml;bernommen werden kann.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Alle Angaben auf dieser Website sind ohne Gew&auml;hr.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Alle Rechte vorbehalten.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 0px; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'><em style="box-sizing: border-box; margin-bottom: 0px;">Die EU-Kommission hat eine Internetplattform zur Online-Beilegung von Streitigkeiten (&bdquo;OS-Plattform&ldquo;) zwischen Unternehmern und Verbrauchern eingerichtet. Die OS-Plattform ist erreichbar unter <a href="https://ec.europa.eu/consumers/odr/" style="box-sizing: border-box; color: rgb(29, 97, 80); text-decoration: none; text-decoration-skip: objects; transition: all 0.2s ease-in-out; margin-bottom: 0px;">https://ec.europa.eu/consumers/odr/</a>.</em></p>
""";
const htmlDataspain = """
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Operador de sitio web:</p>
<h2 style='box-sizing: border-box; margin: 0px 0px 0.5rem; font-family: "PT Serif", serif; font-weight: 500; line-height: 1.2; color: rgb(136, 136, 136); font-size: 1.75rem; caret-color: rgb(136, 136, 136);'>KENSINGTON Finest Properties International AG</h2>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Konstanzerstrasse 37<br style="box-sizing: border-box;">8274 T&auml;gerwilen<br style="box-sizing: border-box;">Suiza<br style="box-sizing: border-box;">Tel.: +41 71 54 49 700<br style="box-sizing: border-box;">Correo electr&oacute;nico: <a href="mailto:muhammed.ashar@kensington-international.com" style="box-sizing: border-box; color: rgb(29, 97, 80); text-decoration: none; text-decoration-skip: objects; transition: all 0.2s ease-in-out; margin-bottom: 0px;">muhammed.ashar@kensington-international.com</a></p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Consejo de Administraci&oacute;n: Mehrdad Bonakdar<br style="box-sizing: border-box; margin-bottom: 0px;">N&uacute;m. de registro mercantil: CH-440.3.026.388-8</p>
<h2 style='box-sizing: border-box; margin: 0px 0px 0.5rem; font-family: "PT Serif", serif; font-weight: 500; line-height: 1.2; color: rgb(136, 136, 136); font-size: 1.75rem; caret-color: rgb(136, 136, 136);'>Aviso de responsabilidad</h2>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>No se permite la reproducci&oacute;n, la descarga ni el uso con otras finalidades de la informaci&oacute;n y los datos comprendidos en esta p&aacute;gina web sin el consentimiento expreso y por escrito del explotador.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Las acciones ileg&iacute;timas ser&aacute;n perseguidas por la v&iacute;a penal.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>KENSINGTON Finest Properties International AG no se responsabiliza en ning&uacute;n caso de la actualidad, la integridad o la veracidad de la informaci&oacute;n proporcionada. KENSINGTON Finest Properties International AG se reserva el derecho a modificar los contenidos peri&oacute;dicamente.<br style="box-sizing: border-box; margin-bottom: 0px;">Los correos electr&oacute;nicos recibidos a trav&eacute;s de este sitio web se tratan con car&aacute;cter estrictamente confidencial. Su direcci&oacute;n de correo electr&oacute;nico solamente se usar&aacute; con fines internos y no se transmitir&aacute;, vender&aacute; ni alquilar&aacute; a terceros.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Los contenidos, las fotograf&iacute;as y toda la informaci&oacute;n sobre inmuebles son proporcionados por los franquiciados de KENSINGTON Finest Properties International AG, por lo que el explotador de este sitio web no puede dar garant&iacute;a alguna.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Toda la informaci&oacute;n comprendida en este sitio web se proporciona sin garant&iacute;as.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 1rem; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'>Todos los derechos reservados.</p>
<p style='box-sizing: border-box; margin-top: 0px; margin-bottom: 0px; caret-color: rgb(136, 136, 136); color: rgb(136, 136, 136); font-family: "PT Sans", sans-serif; font-size: 14px;'><em style="box-sizing: border-box; margin-bottom: 0px;">La Comisi&oacute;n de la UE ha creado una plataforma de Internet para la soluci&oacute;n de controversias en l&iacute;nea (&laquo;OS Platform&raquo;) entre empresas y consumidores. La Plataforma OS puede ser contactada en <a href="https://ec.europa.eu/consumers/odr/" style="box-sizing: border-box; color: rgb(29, 97, 80); text-decoration: none; text-decoration-skip: objects; transition: all 0.2s ease-in-out; margin-bottom: 0px;">https://ec.europa.eu/consumers/odr/</a>.</em></p>
""";

class _RequestSendState extends State<ImprintPage> {
  @override
  void initState() {
    super.initState();
    showDemoActionSheet();
    getcount();
  }

  void showDemoActionSheet() {
    Provider.of<LoginProvider>(context, listen: false)
        .mainlanguage()
        .then((value) {
      changeLocale(context, value);
    });
  }

  CountModel countModel;
  int counter = 0;
  void getcount() {
    Provider.of<LoginProvider>(context, listen: false)
        .count_notification()
        .then((value) {
      if (value) {
        // DialogUtils.hideProgress(context);

        countModel =
            Provider.of<LoginProvider>(context, listen: false).getcount();
        if (countModel.status == "success") {
          setState(() {
            counter = countModel.propertyCount;
          });
        }
      }
    });
  }

  LoginResponse user;
  var unescape = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomWidget.getappbar(context, counter),
        body: ListView(
          children: [
            Align(
              child: Image.asset(
                'assets/appicon/logo.png',
                height: 50,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20, left: 5),
                child: CustomWidget.getheading(
                    translate('drawer_lng.imprintdata'))),
            Html(
              data: widget.langcode == "en"
                  ? htmlData
                  : widget.langcode == "es"
                      ? htmlDataspain
                      : widget.langcode == "de"
                          ? htmlDatagerman
                          : htmlData,
              //Optional parameters:
              style: {
                "html": Style(
                  backgroundColor: Colors.white,
//              color: Colors.white,
                ),
//            "h1": Style(
//              textAlign: TextAlign.center,
//            ),
//             "table": Style(
//               backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
//             ),
//             "tr": Style(
//               border: Border(bottom: BorderSide(color: Colors.grey)),
//             ),
//             "th": Style(
//               padding: EdgeInsets.all(6),
//               backgroundColor: Colors.grey,
//             ),
//             "td": Style(
//               padding: EdgeInsets.all(6),
//               alignment: Alignment.topLeft,
//             ),
                //   "var": Style(fontFamily: 'serif'),
              },
              // customRender: {
              //   "flutter": (RenderContext context, Widget child, attributes, _) {
              //     return FlutterLogo(
              //       style: (attributes['horizontal'] != null)
              //           ? FlutterLogoStyle.horizontal
              //           : FlutterLogoStyle.markOnly,
              //       textColor: context.style.color,
              //       size: context.style.fontSize.size * 5,
              //     );
              //   },
              // },

              onLinkTap: (url) {
                _launchURL("$url");
              },
              onImageTap: (src) {
                print(src);
              },

              onImageError: (exception, stackTrace) {
                print(exception);
                // launchMailto("muhammed.ashar@kensington-international.com");
              },
            ),
          ],
        ));
  }

  _launchURL(String url1) async {
    String url = url1;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchMailto(String mail) async {
    final mailtoLink = Mailto(
      to: [mail],
    );
    await launch('$mailtoLink');
  }
}
