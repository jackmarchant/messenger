export default nodeId => {
  let initialState = {};

  if (!nodeId) {
    return initialState;
  }

  const node = document.getElementById(nodeId);

  if (!node) {
    return initialState;
  }

  return JSON.parse(decodeURIComponent(node.textContent.trim()));
};
