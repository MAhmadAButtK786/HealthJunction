import { FormLabel as Label, Input, Button } from "@chakra-ui/react";
import { Link } from 'react-router-dom';

export default function ForgetPassword() {
  return (
    <>
   <div className="p-3">
        <h1 className="pt-10 text-6xl font-bold text-center text-blue-700 pb-7">
            Health Junction
        </h1>
    </div>
    <div className="flex items-center justify-center ">
   
      <div className="max-w-sm p-6 mx-auto space-y-6 bg-gray-200 rounded-lg shadow-md">
        <div className="space-y-2 text-center">
          <h1 className="text-4xl font-bold text-blue-700">Reset Password</h1>
          <p className="text-gray-700 dark:text-gray-400">Enter your email below to reset your password</p>
        </div>
        <div className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="email" className="text-gray-700">Email</Label>
            <Input id="email" placeholder="m@example.com" required type="email" className="w-full p-2 border-gray-300 rounded-md focus:border-indigo-500 focus:ring-indigo-500"/>
          </div>
          <div>
              <Button
                className="relative flex justify-center w-full px-4 py-2 text-sm font-medium text-white bg-indigo-700 border border-transparent rounded-md group hover:bg-indigo-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                type="submit"
              >
                Reset Password
              </Button>
            </div>
          <div className="mt-4 text-sm text-center">
            Remember your password?
            <Link className="text-indigo-700 underline hover:text-indigo-500" to="/">
              Login
            </Link>
          </div>
        </div>
      </div>
    </div>
    </>
  )
}
