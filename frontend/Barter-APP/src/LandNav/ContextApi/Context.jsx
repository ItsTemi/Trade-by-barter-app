import { useEffect, useState, createContext } from "react";

const AccessProv = createContext();

// console.log(JSON.parse(localStorage.getItem("user")));

const AccessProvider = ({ children }) => {
  const [access, setAccess] = useState(
    JSON.parse(localStorage.getItem("user"))
  );
  const [likes, setLikes] = useState(0);

  useEffect(() => {
    if (localStorage.getItem("user") == null) {
      localStorage.setItem(
        "user",
        JSON.stringify({
          isLoggedIn: false,

          token: "",
          userId: "",
        })
      );
    } else {
      setAccess(JSON.parse(localStorage.getItem("user")));
    }
  }, []);
  return (
    <div>
      <AccessProv.Provider value={{ access, setAccess, likes, setLikes }}>
        {children}
      </AccessProv.Provider>
      {/* {login} */}
    </div>
  );
};

export { AccessProv, AccessProvider };
