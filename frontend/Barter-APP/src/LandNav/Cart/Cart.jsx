import React from "react";
import "./cart.css";
import { AiOutlineShoppingCart } from "react-icons/ai";
import axios from "axios";
import { useState, useEffect } from "react";
import { useContext } from "react";
import { AccessProv } from "../ContextApi/Context";
import Nav from "../Nav";

const url2 =
  "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/like/getAllLikes";

function Cart() {
  const { access } = useContext(AccessProv);
  const [items, setItems] = useState();
  const likeItem = () => {
    axios
      .get(url2, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${access.token}`,
        },
      })
      .then((result) => {
        setItems(result.data);
        //  setAccess({
        //   isLoggedIn: true,
        //   token: response.data.msg,
        //   userId: response.data.userId,
        // });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  useEffect(() => {
    likeItem();
    console.log(access.token);
  }, []);

  return (
    <div>
      {" "}
      <Nav access={access} />
      <div className="cart-container">
        <div className="cart-body">
          <div className="cart-picture">
            <div className="cart-box">
              <AiOutlineShoppingCart />
            </div>
          </div>

          <div className="cart-text">
            <h1 className="cart-h1">Your cart is empty!!</h1>
            {items?.like.map((item, k) => {
              const { itemLiked } = item;
              return itemLiked.map((item2) => {
                const { itemName } = item2;
                return (
                  <div>
                    <p>{itemName}</p>
                  </div>
                );
              });
            })}

            <p className="cart-p">
              Browse our categories and discover our best deals
            </p>
          </div>

          <div className="shopping">
            <button className="cart-shopping">START SHOPPING</button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Cart;
