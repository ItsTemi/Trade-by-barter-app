import React from "react";
import "./Nav.css";
import Login from "./Login/Login";
import { useNavigate } from "react-router-dom";
import { CgProfile } from "react-icons/cg";
import { AiOutlineShoppingCart } from "react-icons/ai";
import { MdOutlineEditNotifications } from "react-icons/md";
// import { NavLink } from "react-router-dom";
import { useState, useEffect } from "react";
import { AccessProv } from "./ContextApi/Context";
import { useContext } from "react";
import axios from "axios";
// import { useEffect } from "react";

const url =
  "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/like/getAllLikes";

function Nav({ access }) {
  const { likes, setLikes } = useContext(AccessProv);

  console.log("====================================");
  // useEffect(() => {
  //   console.log(access);
  // }, []);
  const login = () => {
    navigate("/login");
  };

  const signup = () => {
    navigate("/signup");
  };

  const liked = () => {
    axios
      .get(url, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${access.token}`,
        },
      })
      .then((response) => {
        setLikes(response.data.like.length);
        console.log(response);
      })

      .catch((error) => {
        console.log(error);
      });
  };

  useEffect(() => {
    liked();
    // console.log(response);
  }, []);

  return (
    <div>
      <nav className="nav">
        <div className="barterApp">WeBarter</div>

        <div className="navBtn">
          {!access?.isLoggedIn ? (
            <>
              <div className="btnProfile">
                <button onClick={signup}>SIGNUP</button>
              </div>

              <div className="btnProfile">
                <button onClick={login}>LOGIN</button>
              </div>
            </>
          ) : (
            <div className="list">
              <ul>
                <li>
                  <a href="">
                    <MdOutlineEditNotifications className="iconss" />
                    Needs
                  </a>
                </li>

                <li>
                  <a href="/cart" className="isLiked">
                    <AiOutlineShoppingCart className="iconss" /> Cart
                    <span className="icons-badge">{likes}</span>
                  </a>
                </li>
                <li>
                  <a href="/pro">
                    <CgProfile className="iconss" /> Profile
                  </a>
                </li>
              </ul>
            </div>
          )}
        </div>
      </nav>
    </div>
  );
}

export default Nav;
