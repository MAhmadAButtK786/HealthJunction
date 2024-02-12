import React from 'react';
import Slider from 'react-slick';
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';

const HPHomeCarousel = () => {
  const settings = {
    dots: true,
    infinite: true, // Set infinite to true for continuous sliding
    speed: 700,
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 1300,
    customPaging: (i) => (
      <div
        style={{
          width: '15px',
          height: '15px',
          borderRadius: '50%',
          background: 'rgba(255, 255, 255, 0.8)',
        }}
      ></div>
    ),
  };

  return (
    <div className="max-w-screen-lg pt-10 mx-auto">
      <Slider {...settings} className="mb-4">
        
        
         
          <div className="relative h-64">
            <img
              src="images/img/Lab/L1.jpg"
              alt="Slide 1"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        
        <div className="relative h-64">
            <img
              src="images/img/Hos/hos5.jpg"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        <div className="relative h-64">
            <img
              src="images/img/Hos/hos2.jpg"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Lab/l3.jpg"
              alt="Slide 2"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Lab/l4.jpg"
              alt="Slide 3"

              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Lab/L6.jpg"
              alt="Slide 4"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Bank/testTube.jpg"
              alt="Slide 5"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Bank/test2.jpg"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Hos/Hos.jpg"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Bank/Blood.jpg"
              alt="Blood"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Bank/BloodGroups.png"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Hos/hos3.jpg"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
          
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Hos/hos4.jpg"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        
        <div>
          <div className="relative h-64">
            <img
              src="images/Icons Health.JPG"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/bloodd.jpg"
              alt="Slide 6"
              className="absolute inset-0 w-full h-full"
              style={{ width: '100%', height: '100%' }}
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
      </Slider>
    </div>
  );
};

export default HPHomeCarousel;
