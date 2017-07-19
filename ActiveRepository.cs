using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CMS.Core;
using CMS.Core.Interfaces;
using CMS.Core.Models;
using PetaPoco;

namespace CMS.Infrastructure.Repositories
{
    public class ActiveRepository :IActiveRepository
    {
        Database CMS = new Database("CMSConnection");

        public void Add(Core.Models.Active activeRecord)
        {
            CMS.Insert(activeRecord);
        }

        public void Edit(Core.Models.Active activeRecord)
        {
            CMS.Update(activeRecord);
        }

        public Core.Models.Active FindActiveByID(int activeID)
        {
            var a =  CMS.Single<Core.Models.Active>(activeID);
            return a; 
        }
		
		 public Core.Models.Active FindActiveByDocument(Guid documentGUID)
        {
            var a =  CMS.Single<Core.Models.Active>(documentGUID);
            return a; 
        }

        public IEnumerable<Core.Models.Active> ListActive()()
        {
            var a = CMS.Query<Core.Models.Active>("select * from Active");
            return a;
        }

        public void Remove(int activeRecordID)
        {
            CMS.Delete(activeRecordID);
        }
    }
}
