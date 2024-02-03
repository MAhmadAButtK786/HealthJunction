import React from "react";
import { Link } from "react-router-dom";

const Login = () => {
  return (
    <>
      <div
        style={{
          backgroundColor: "#1428DD",
          minHeight: "100vh",
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
        }}
      >
        {/* component */}
        <link rel="preconnect" href="https://rsms.me/" />
        <link rel="stylesheet" href="https://rsms.me/inter/inter.css" />
        <style
          dangerouslySetInnerHTML={{
            __html:
              "\n:root { font-family: 'Inter', sans-serif; }\n@supports (font-variation-settings: normal) {\n  :root { font-family: 'Inter var', sans-serif; }\n}\n",
          }}
        />
        <div className="p-3">
          <h1 className="text-6xl font-bold text-center text-white">
            Health Junction
          </h1>
        </div>
        <div className="max-w-lg p-8 mx-auto my-10 bg-white shadow rounded-xl shadow-slate-300 md:w-2/3 lg:w-1/2 xl:w-1/3">
          <h1 className="text-4xl font-medium">Login</h1>
          <p className="text-slate-500">Hi, Welcome back 👋</p>
          <div className="my-5">
            <button className="flex items-center justify-center w-full py-3 my-3 space-x-2 text-center transition duration-150 border rounded-lg border-slate-200 text-slate-700 hover:border-slate-400 hover:text-slate-900 hover:shadow">
              <img
                src="https://www.svgrepo.com/show/355037/google.svg"
                className="w-6 h-6"
                alt=""
              />{" "}
              <span>Login with Google</span>
            </button>
          </div>
          <form action="" className="my-10">
            <div className="flex flex-col space-y-5">
            <div className="flex flex-col space-y-5">
              <label htmlFor="email">
                <p className="pb-2 font-medium text-slate-700">Email address</p>
                <input
                  id="email"
                  name="email"
                  type="email"
                  className="w-full px-3 py-3 border rounded-lg border-slate-200 focus:outline-none focus:border-slate-500 hover:shadow"
                  placeholder="Enter email address"
                />
              </label>
              <label htmlFor="password">
                <p className="pb-2 font-medium text-slate-700">Password</p>
                <input
                  id="password"
                  name="password"
                  type="password"
                  className="w-full px-3 py-3 border rounded-lg border-slate-200 focus:outline-none focus:border-slate-500 hover:shadow"
                  placeholder="Enter your password"
                />
              </label>
              <div className="flex flex-row justify-between">
                <div>
                  <label htmlFor="remember" className="">
                    <input
                      type="checkbox"
                      id="remember"
                      className="w-4 h-4 m-2 border-slate-200 focus:bg-indigo-600"
                    />
                    Remember me
                  </label>
                </div>
                <div>
                  <Link
                    to="/forgetPassword"
                    className="font-medium text-indigo-600"
                  >
                    Forgot Password?
                  </Link>
                </div>
              </div>
            </div>
            </div>
          </form>
          <div className="flex flex-col space-y-5">
            <Link
              to="/home"
              className="inline-flex items-center justify-center w-full py-3 space-x-2 font-medium text-white bg-indigo-600 border-indigo-500 rounded-lg hover:bg-indigo-500 hover:shadow"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="w-6 h-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                strokeWidth={2}
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"
                />
              </svg>
              <span>Login</span>
            </Link>
            <p className="text-center">
              Not registered yet?{" "}
              <Link
                to="/register"
                className="inline-flex items-center space-x-1 font-medium text-indigo-600"
              >
                <span>Register now </span>
                <span>
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="w-4 h-4"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    strokeWidth={2}
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"
                    />
                  </svg>
                </span>
              </Link>
            </p>
          </div>
        </div>
      </div>
    </>
  );
};

export default Login;
