import React, { Fragment } from 'react';
import UserList from './UserList';
import ThreadList from './ThreadList';
import { Link } from 'react-router-dom';

const Dashboard = ({ data }) => {
  return (
    <Fragment>
      <Link to="/signup">Sign Up</Link>
      <ThreadList data={data} />
      <UserList data={data} />
    </Fragment>
  );
};

export default Dashboard;
