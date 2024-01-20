// Accordion.js
import React, { useState } from 'react';
import { useSpring, animated } from 'react-spring';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faPlus, faMinus } from '@fortawesome/free-solid-svg-icons';
import blooddata from './faqdata';
import './style.css';
import BBNavbar from '../BBNavbar';

const Accordion = () => {
  const [selected, setSelected] = useState(null);

  const handleSingleSelection = (id) => {
    setSelected((prevSelected) => (prevSelected === id ? null : id));
  };

  // Add a spring animation for the accordion content
  const contentProps = useSpring({
    height: selected ? 'auto' : 0, // Adjusted the '0%' to 0
    opacity: selected ? 1 : 0,
    overflow: 'hidden',
  });

  return (
    <>
      <BBNavbar />
      <div className="accordion-wrapper">
        <p className='p-6 text-red-700 text-4xl font-bold'>
          Frequently Asked Questions 
        </p>
        <div className="accordion">
          {blooddata && blooddata.length > 0 ? (
            blooddata.map((dataItem) => (
              <div key={dataItem.id} className={`accordion-item ${selected === dataItem.id ? 'active' : ''}`}>
                <div
                  className={`accordion-title ${selected === dataItem.id ? 'selected' : ''}`}
                  onClick={() => handleSingleSelection(dataItem.id)}
                >
                  <h3>{dataItem.question}</h3>
                  <FontAwesomeIcon icon={selected === dataItem.id ? faMinus : faPlus} color="white" />
                </div>
                {selected === dataItem.id && (
                  <animated.div style={contentProps} className="accordion-content">
                    <h4>{dataItem.answer}</h4>
                  </animated.div>
                )}
              </div>
            ))
          ) : (
            <div>No Data Found</div>
          )}
        </div>
      </div>
    </>
  );
};

export default Accordion;
