import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/util/dimensions.dart';

class PolicyScreen extends StatefulWidget {
  final String title;
  const PolicyScreen({super.key, required this.title});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
        physics: const BouncingScrollPhysics(),
        child: Html(
          style: {
            'html': Style(textAlign: TextAlign.left)
          },
          data:  """<p><strong>This is a Demo Privacy Policy</strong></p>
<p>This policy explains how the Codemoly website and related applications (the &ldquo;Site&rdquo;, &ldquo;we&rdquo; or &ldquo;us&rdquo;) collect, use, share, and protect the personal information that we collect through this Site or different channels. Codemoly has established the Site to connect users who need food or grocery items to be shipped or delivered by riders from affiliated restaurants or shops to their desired locations. This policy also applies to any mobile applications that we develop for use with our services on the Site, and references to this &ldquo;Site&rdquo;, &ldquo;we&rdquo; or &ldquo;us&rdquo; are intended to also include these mobile applications. Please read below to learn more about our information policies. By using this Site, you agree to these policies.</p>
<p><strong>How the Information is Collected</strong></p>
<p><strong>Information Provided by Web Browser</strong><br>You have to provide us with personal information such as your name, contact number, mailing address, and email ID. Our app will also fetch your location information to provide you with the best service. Like many other websites, we may record information that your web browser routinely shares, such as your browser type, browser language, software and hardware attributes, the date and time of your visit, the web page from which you came, your Internet Protocol address, the geographic location associated with that address, the pages on this Site that you visit, and the time you spent on those pages. This is generally anonymous data that we collect on an aggregate basis.</p>
<p><strong>Personal Information That You Provide</strong><br>If you want to use our service, you must create an account on our Site. To establish your account, we will ask for personally identifiable information that can be used to contact or identify you, which may include your name, phone number, and email address. We may also collect demographic information about you, such as your zip code, and allow you to submit additional information that will be part of your profile. Other than the basic information that we need to establish your account, it will be up to you to decide how much information to share as part of your profile. We encourage you to think carefully about the information that you share and recommend that you guard your identity and sensitive information. Of course, you can review and revise your profile at any time.</p>
<p><strong>Payment Information</strong><br>To make payments online for availing our services, you must provide the bank account, mobile financial service (MFS), debit card, or credit card information to the Codemoly platform.</p>
<p><strong>How the Information is Collected</strong></p>
<p><strong>Session and Persistent Cookies</strong><br>Cookies are small text files that are placed on your computer by websites that you visit. They are widely used to make websites work or work more efficiently, as well as to provide information to the owners of the site. As is commonly done on websites, we may use cookies and similar technology to keep track of our users and the services they have selected. We use both &ldquo;session&rdquo; and &ldquo;persistent&rdquo; cookies. Session cookies are deleted after you leave our website and close your browser. We use data collected with session cookies to enable certain features on our Site, help us understand how users interact with our Site, and monitor, at an aggregate level, Site usage and web traffic routing. We may allow business partners who provide services to our Site to place cookies on your computer to assist us in analyzing usage data. We do not allow these business partners to collect your personal information from our website except as may be necessary for the services that they provide.</p>
<p><strong>Web Beacons</strong><br>We may also use web beacons or similar technology to help us track the effectiveness of our communications.</p>
<p><strong>Advertising Cookies</strong><br>We may use third parties, such as Google, to serve ads about our website over the internet. These third parties may use cookies to identify ads that may be relevant to your interest (for example, based on your recent visit to our website), to limit the number of times that you see an ad, and to measure the effectiveness of the ads.</p>
<p><strong>Google Analytics</strong><br>We may also use Google Analytics or a similar service to gather statistical information about the visitors to this Site and how they use the Site. This is also done on an anonymous basis. We will not try to associate anonymous data with your personally identifiable data. If you would like to learn more about Google Analytics, please click <a rel="noopener" target="_new" href="https://analytics.google.com">here</a>.</p>"""
                    ),
      ),
    );
  }
}
