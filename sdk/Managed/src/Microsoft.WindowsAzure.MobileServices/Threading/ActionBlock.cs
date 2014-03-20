﻿// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Microsoft.WindowsAzure.MobileServices.Threading
{
    /// <summary>
    /// Queue for executing asynchronous tasks in a first-in-first-out fashion.
    /// </summary>
    internal class ActionBlock
    {
        AsyncLock theLock;

        public ActionBlock()
        {
            theLock = new AsyncLock();
        }

        public async Task Post(Func<Task> action, CancellationToken cancellationToken)
        {
            using (await theLock.Acquire(cancellationToken))
            {
                await action(); 
            }
        }
    }
}