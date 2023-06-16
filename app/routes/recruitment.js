/*
|----------------------------------------------
| RECRUITMENT
| 1. Candidate Profile
| 2. Schedule
| 3. Rating
| 4. Joining
|----------------------------------------------
*/
app.get('/recruitment/candidate-profile', guard, recruitment_candidate.index);
app.post('/recruitment/candidate-profile', guard, recruitment_candidate.store);
app.put('/recruitment/candidate-profile', guard, recruitment_candidate.update);
app.post('/recruitment/candidate-profile/edit', guard, recruitment_candidate.edit);
app.post('/recruitment/candidate-profile/fetch', guard, recruitment_candidate.fetch);
app.post('/recruitment/candidate-profile/archive', guard, recruitment_candidate.archive);

app.get('/recruitment/schedule', guard, recruitment_schedule.index);
app.post('/recruitment/schedule', guard, recruitment_schedule.store);
app.put('/recruitment/schedule', guard, recruitment_schedule.update);
app.post('/recruitment/schedule/get', guard, recruitment_schedule.get);
app.post('/recruitment/schedule/init', guard, recruitment_schedule.init);
app.post('/recruitment/schedule/edit', guard, recruitment_schedule.edit);

app.get('/recruitment/rating', guard, recruitment_rating.index);
app.post('/recruitment/rating', guard, recruitment_rating.store);
app.post('/recruitment/rating/get', guard, recruitment_rating.get);
app.post('/recruitment/rating/fetch', guard, recruitment_rating.fetch);

app.get('/recruitment/joining', guard, recruitment_joining.index);
app.post('/recruitment/joining', guard, recruitment_joining.update);
app.post('/recruitment/joining/fetch', guard, recruitment_joining.fetch);
app.post('/recruitment/joining/edit', guard, recruitment_joining.edit);