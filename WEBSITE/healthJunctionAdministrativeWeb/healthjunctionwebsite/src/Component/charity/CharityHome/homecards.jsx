import React from 'react';

function CHomecards() {
  return (
    <>

  <style
    dangerouslySetInnerHTML={{
      __html:
        '\n\t.component {\n\t\t font-family: "Noto Sans Arabic", sans-serif;\n\t}\n\n\tblockquote {\n\t\tbackground:\n\t\t\tlinear-gradient(to right, #039be5 6px, transparent 4px) 0 100%,\n\t\t\tlinear-gradient(to left, #039be5 6px, transparent 4px) 100% 0,\n\t\t\tlinear-gradient(to bottom, #039be5 6px, transparent 4px) 100% 0,\n\t\t\tlinear-gradient(to top, #039be5 6px, transparent 4px) 0 100%;\n\t\tbackground-repeat: no-repeat;\n\t\tbackground-size: 20px 20px;\n\t}\n\n\t/* -- create the quotation marks -- */\n\tblockquote:before,\n\tblockquote:after {\n\t\tfont-family: FontAwesome;\n\t\tposition: absolute;\n\t\tcolor: #039be5;\n\t\tfont-size: 34px;\n\t}\n\n\tblockquote:before {\n\t\tcontent: "\\f10d";\n\t\ttop: -12px;\n\t\tmargin-right: -20px;\n\t\tright: 100%;\n\t}\n\n\tblockquote:after {\n\t\tcontent: "\\f10e";\n\t\tmargin-left: -20px;\n\t\tleft: 100%;\n\t\ttop: auto;\n\t\tbottom: -20px;\n\t}\n'
    }}
  />
  <link
    rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
  />
  <section className="p-10 mx-1 bg-white component md:mx-10 ">
    <blockquote className="relative w-full p-10 m-1 text-xl text-center text-black">
    <p className="mb-4">
       <b> يَـٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوٓا۟ أَنفِقُوا۟ مِن طَيِّبَـٰتِ مَا كَسَبْتُمْ وَمِمَّآ أَخْرَجْنَا لَكُم مِّنَ ٱلْأَرْضِ ۖ وَلَا تَيَمَّمُوا۟ ٱلْخَبِيثَ مِنْهُ تُنفِقُونَ وَلَسْتُم بِـَٔاخِذِيهِ إِلَّآ أَن تُغْمِضُوا۟ فِيهِ ۚ وَٱعْلَمُوٓا۟ أَنَّ ٱللَّهَ غَنِىٌّ حَمِيدٌ 
       </b> </p>
        <footer className="text-sm text-gray-700">
        O believers! Donate from the best of what you have earned and of what We have produced for you from the earth. Do not pick out worthless things for donation, which you yourselves would only accept with closed eyes. And know that Allah is Self-Sufficient, Praiseworthy.
          <br /> <cite>Quran, [Surah Al-Baqarah (2:267)]</cite></footer>
    </blockquote>
  </section>
</>


  );
}

export default CHomecards;
