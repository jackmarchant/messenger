import React from 'react';
import PropTypes from 'prop-types';

const RelayRenderContainer = (
  Component,
  errorHandler = () => {},
) => {
  const RelayWrapper = ({ error, props }) => {
    if (props) {
      return <Component data={props} />;
    } else if (error) {
      //eslint-disable-next-line no-console
      console.error(error);

      const errors = error.source && error.source.errors;

      return errorHandler(errors);
    } else {
      return (
        <div className="loading">
          <p>
            Loading...
          </p>
        </div>
      );
    }
  };

  RelayWrapper.propTypes = {
    error: PropTypes.object,
    props: PropTypes.object,
  };

  RelayWrapper.displayName = `RelayRenderContainer(${Component.displayName ||
    Component.name ||
    'Component'})`;

  return RelayWrapper;
};

export default RelayRenderContainer;