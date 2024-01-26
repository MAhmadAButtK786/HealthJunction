import React from 'react';
import CStory from './story';
function CHomecards() {
  return (
    <>
    <div className="text-purple-900 text-xl font-bold text-center p-10">
      <blockquote className="max-w-2xl mx-auto">
        <p className="mb-4">
          " O you who believe, you shall give to charity from the good things you earn, and from what we have produced for you from the earth. Do not pick out the bad therein to give away, when you yourselves do not accept it unless your eyes are closed. You should know that Allah is Rich, Praiseworthy."
        </p>
        <footer className="text-gray-600 text-sm">Quran, [Surah Al-Baqarah (2:267)]</footer>
      </blockquote>

    </div>
    <div>
    <CStory/>
    </div>
    </>
  );
}

export default CHomecards;
