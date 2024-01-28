import React from 'react';
import CStory from './story';
function CHomecards() {
  return (
    <>
    <div className="text-purple-900 text-xl font-bold text-center p-10">
      <blockquote className="max-w-2xl mx-auto">
        <p className="mb-4">
        يَـٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوٓا۟ أَنفِقُوا۟ مِن طَيِّبَـٰتِ مَا كَسَبْتُمْ وَمِمَّآ أَخْرَجْنَا لَكُم مِّنَ ٱلْأَرْضِ ۖ وَلَا تَيَمَّمُوا۟ ٱلْخَبِيثَ مِنْهُ تُنفِقُونَ وَلَسْتُم بِـَٔاخِذِيهِ إِلَّآ أَن تُغْمِضُوا۟ فِيهِ ۚ وَٱعْلَمُوٓا۟ أَنَّ ٱللَّهَ غَنِىٌّ حَمِيدٌ 
        </p>
        <footer className="text-gray-700 text-sm">
        O believers! Donate from the best of what you have earned and of what We have produced for you from the earth. Do not pick out worthless things for donation, which you yourselves would only accept with closed eyes. And know that Allah is Self-Sufficient, Praiseworthy.
          <br />Quran, [Surah Al-Baqarah (2:267)]</footer>
      </blockquote>

    </div>
    <div>
    <CStory/>
    </div>
    </>
  );
}

export default CHomecards;
