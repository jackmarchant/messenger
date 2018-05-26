import React, { Fragment } from 'react';
import UserList from './UserList';
import ThreadList from './ThreadList';

const Dashboard = ({ data }) => {
  return (
    <Fragment>
      <ThreadList data={data} />
      <UserList data={data} />
    </Fragment>
  );
};

export default Dashboard;
