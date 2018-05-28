import React, { Fragment } from 'react';
import UserList from './UserList';
import ThreadList from './ThreadList';
import { Link } from 'react-router-dom';

const Dashboard = ({ data, isAuthenticated }) => {
  return (
    <Fragment>
      {isAuthenticated === false && (
        <Fragment>
          <Link to="/signup">Sign up</Link>
          <Link to="/login">Log in</Link>
        </Fragment>
      )}
      <ThreadList data={data} />
      <UserList data={data} />
    </Fragment>
  );
};

export default Dashboard;
