import React from 'react';
import Slider from 'react-slick';
import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';

const LabHomeContent = () => {
  const settings = {
    dots: true,
    infinite: true, // Set infinite to true for continuous sliding
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 1000,
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
    <div className="max-w-screen-lg mx-auto pt-2">
      <Slider {...settings} className="mb-4">
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Lab/L1.jpg"
              alt="Slide 1"
              className="absolute inset-0 w-full h-full"
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
        <div>
          <div className="relative h-64">
            <img
              src="images/img/Lab/l3.jpg"
              alt="Slide 2"
              className="absolute inset-0 w-full h-full"
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
            />
            <div className="absolute inset-0 flex items-center justify-center"></div>
          </div>
        </div>
      </Slider>
    </div>
  );
};

export default LabHomeContent;
