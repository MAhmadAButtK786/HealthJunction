import React from 'react';
import Slider from 'react-slick';
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';


const LabHomeContent = () => {
    const settings = {
      dots: true,
      infinite: true,
      speed: 500,
      slidesToShow: 1,
      slidesToScroll: 1,
    };
  
    return (
      <div className="max-w-screen-lg mx-auto pt-2">
        <Slider {...settings} className="mb-4">
          <div>
            <div className="relative h-64">
              <img src="" alt="Slide 1" className="absolute inset-0 w-full h-full object-cover" />
              <div className="absolute inset-0 flex items-center justify-center">
             
              </div>
            </div>
          </div>
          <div>
            <div className="relative h-64">
              <img src="" alt="Slide 2" className="absolute inset-0 w-full h-full object-cover" />
              <div className="absolute inset-0 flex items-center justify-center">
                
              </div>
            </div>
          </div>
          <div>
            <div className="relative h-64">
              <img src="" alt="Slide 3" className="absolute inset-0 w-full h-full object-cover" />
              <div className="absolute inset-0 flex items-center justify-center">
              </div>
            </div>
          </div>
        </Slider>
      </div>
    );
  };
export default LabHomeContent;
